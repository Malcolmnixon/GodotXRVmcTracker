extends Node


## VMC Reader Script
##
## This script reads VMC packets and uses the data to generate XRFaceTracker and
## XRBodyTracker data for driving avatars.


## VMC Position options
enum VMCPosition {
	FREE,			## Free movement
	CALIBRATE,		## Calibrate horizontal position on first frame
	LOCKED			## Lock horizontal position
}


# OSC reader instance
var _osc_reader : OSCReader = OSCReader.new()

# Face tracker instance to publish tracking data
var _face_tracker : XRFaceTracker = XRFaceTracker.new()

# Body tracker instance to publish tracking data
var _body_tracker : XRBodyTracker = XRBodyTracker.new()

# VMC Position mode
var _vmc_position_mode : VMCPosition = VMCPosition.FREE

# Array of VMC joint relative positions
var _vmc_rel_positions : Array[Vector3] = []

# Array of VMC joint relative rotations
var _vmc_rel_rotations : Array[Quaternion] = []

# Array of VMC joint absolute positions
var _vmc_abs_positions : Array[Vector3] = []

# Array of VMC joint absolute rotations
var _vmc_abs_rotations : Array[Quaternion] = []

# Array of VMC face blends
var _vmc_face_blends : Array[float] = []

# Position calibration
var _position_calibration : Vector3 = Vector3.ZERO

# True if new joint data available
var _new_joints : bool = false

# True if new face blend data available
var _new_face_blends : bool = false

# Calibrated flag
var _position_calibrated : bool = false


func _enter_tree() -> void:
	# Fill the position and rotation arrays
	_vmc_rel_positions.resize(VMCBody.Joint.COUNT)
	_vmc_rel_rotations.resize(VMCBody.Joint.COUNT)
	_vmc_abs_positions.resize(VMCBody.Joint.COUNT)
	_vmc_abs_rotations.resize(VMCBody.Joint.COUNT)
	_vmc_rel_positions.fill(Vector3.ZERO)
	_vmc_rel_rotations.fill(Quaternion.IDENTITY)
	_vmc_abs_positions.fill(Vector3.ZERO)
	_vmc_abs_rotations.fill(Quaternion.IDENTITY)

	# Fill the face blend array
	_vmc_face_blends.resize(VMCBody.FaceBlend.COUNT)
	_vmc_face_blends.fill(0.0)

	# Get the face tracker name
	var face_tracker_name : String = ProjectSettings.get_setting(
		"godot_vmc_tracker/tracking/face_tracker_name",
		"/vmc/head")

	# Register the face tracker
	XRServer.add_face_tracker(face_tracker_name, _face_tracker)

	# Get the body tracker name
	var body_tracker_name : String = ProjectSettings.get_setting(
		"godot_vmc_tracker/tracking/body_tracker_name",
		"/vmc/body")

	# Register the body tracker
	XRServer.add_body_tracker(body_tracker_name, _body_tracker)

	# Get the position mode
	_vmc_position_mode = ProjectSettings.get_setting(
		"godot_vmc_tracker/tracking/position_mode",
		0)

	# Get the VMC port number
	var udp_listener_port : int = ProjectSettings.get_setting(
		"godot_vmc_tracker/network/udp_listener_port",
		39539)

	# Start listening for VMC packets
	_osc_reader.on_osc_packet.connect(_on_osc_packet)
	_osc_reader.listen(udp_listener_port)


func _process(_delta : float) -> void:
	# Poll for incoming packets
	_osc_reader.poll()


# Handle received OSC packet data
func _on_osc_packet(data : Array) -> void:
	# Process all OSC entries
	for entry in data:
		match entry[0]:
			"/VMC/Ext/Root/Pos":
				_on_vmc_ext_root_pos(entry)
			"/VMC/Ext/Bone/Pos":
				_on_vmc_ext_bone_pos(entry)
			"/VMC/Ext/Blend/Val":
				_on_vmc_ext_blend_val(entry)

	# Process new joint data
	if _new_joints:
		_new_joints = false
		_process_joints()

	# Process new face blends
	if _new_face_blends:
		_new_face_blends = false
		_process_face_blends()


# Handle a VMC root position
func _on_vmc_ext_root_pos(entry : Array) -> void:
	var pos := Vector3(entry[2], entry[3], -entry[4])
	var rot := Quaternion(entry[5], entry[6], -entry[7], -entry[8])

	# Set the root transform
	_body_tracker.set_joint_transform(
		XRBodyTracker.JOINT_ROOT,
		Transform3D(
			Basis(rot),
			pos))

	# Set the root joint flags
	_body_tracker.set_joint_flags(
		XRBodyTracker.JOINT_ROOT,
		XRBodyTracker.JOINT_FLAG_ORIENTATION_TRACKED |
		XRBodyTracker.JOINT_FLAG_ORIENTATION_VALID |
		XRBodyTracker.JOINT_FLAG_POSITION_TRACKED |
		XRBodyTracker.JOINT_FLAG_POSITION_VALID)


# Handle a VMC bone position
func _on_vmc_ext_bone_pos(entry : Array) -> void:
	# Get the VMC joint
	var joint : VMCBody.Joint = VMCBody.JointNames.get(entry[1], -1)
	if joint < 0:
		return

	# Save the relative positions and rotations
	var pos := Vector3(entry[2], entry[3], -entry[4])
	var rot := Quaternion(entry[5], entry[6], -entry[7], -entry[8])

	# If hips then consider position calibration
	if joint == VMCBody.Joint.HIPS:
		match _vmc_position_mode:
			VMCPosition.CALIBRATE:
				# Calibrate on first position
				if not _position_calibrated:
					_position_calibrated = true
					_position_calibration = pos.slide(Vector3.UP)

				# Apply calibration
				pos -= _position_calibration

			VMCPosition.LOCKED:
				# Project position to vertical axis
				print("Locking hips from: ", pos)
				pos = pos.project(Vector3.UP)
				print("to: ", pos)

	# Save the joint
	_vmc_rel_positions[joint] = pos
	_vmc_rel_rotations[joint] = rot
	_new_joints = true


# Handle a VMC face blend value
func _on_vmc_ext_blend_val(entry : Array) -> void:
	# Get the VMC face blend
	var blend : VMCBody.FaceBlend = VMCBody.FaceBlendNames.get(entry[1], -1)
	if blend < 0:
		return

	# Save the face blend
	_vmc_face_blends[blend] = entry[2]
	_new_face_blends = true
	pass


# Process VMC joint data into XRBodyTracker data
func _process_joints() -> void:
	# Iterate over the joints
	for joint in VMCBody.Joint.COUNT:
		# Get the joint information and relative location
		var parent_joint := VMCBody.JointParent[joint]
		var pos := _vmc_rel_positions[joint]
		var rot := _vmc_rel_rotations[joint]

		# If child-joint then convert relative to absolute
		if parent_joint >= 0:
			var parent_pos := _vmc_abs_positions[parent_joint]
			var parent_rot := _vmc_abs_rotations[parent_joint]
			pos = parent_pos + parent_rot * pos
			rot = parent_rot * rot

		# Save absolute position
		_vmc_abs_positions[joint] = pos
		_vmc_abs_rotations[joint] = rot

	# Apply to the XRBodyTracker
	for joint in VMCBody.JointMapping:
		var body : XRBodyTracker.Joint = joint["body"]
		var vmc : VMCBody.Joint = joint["vmc"]
		var roll : Quaternion = joint["roll"]

		# Set the joint transform
		_body_tracker.set_joint_transform(
			body,
			Transform3D(
				Basis(_vmc_abs_rotations[vmc] * roll),
				_vmc_abs_positions[vmc]))

		# Set the joint flags
		_body_tracker.set_joint_flags(
			body,
			XRBodyTracker.JOINT_FLAG_ORIENTATION_TRACKED |
			XRBodyTracker.JOINT_FLAG_ORIENTATION_VALID |
			XRBodyTracker.JOINT_FLAG_POSITION_TRACKED |
			XRBodyTracker.JOINT_FLAG_POSITION_VALID)

	# Indicate we have upper-body, lower-body, and hands
	_body_tracker.body_flags = \
		XRBodyTracker.BODY_FLAG_UPPER_BODY_SUPPORTED | \
		XRBodyTracker.BODY_FLAG_LOWER_BODY_SUPPORTED | \
		XRBodyTracker.BODY_FLAG_HANDS_SUPPORTED

	# Indicate we have tracking data
	_body_tracker.has_tracking_data = true


# Process VMC face blend data into XRFaceTracker
func _process_face_blends() -> void:
	# Apply to the XRFaceTracker
	for blend in VMCBody.FaceBlendMapping:
		var face : Array = blend["face"]
		var vmc : Array = blend["vmc"]

		var weight := 0.0
		for v in vmc:
			weight += _vmc_face_blends[v]
		weight /= vmc.size()

		# Set the face blend weight
		for f in face:
			_face_tracker.set_blend_shape(f, weight)
