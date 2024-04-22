class_name VMCSource
extends Object


## VMC Tracker Script
##
## This script processes VMC packets into XRFaceTracker and XRBodyTracker data
## for driving avatars.


## Enumeration of position modes
enum PositionMode {
	FREE,			## Free movement
	CALIBRATE,		## Calibrate horizontal position on the first frame
	LOCKED			## Lock horizontal position
}


## Body tracking flags
const BODY_TRACKING := \
	XRBodyTracker.BODY_FLAG_UPPER_BODY_SUPPORTED | \
	XRBodyTracker.BODY_FLAG_LOWER_BODY_SUPPORTED | \
	XRBodyTracker.BODY_FLAG_HANDS_SUPPORTED

## Joint tracking flags
const JOINT_TRACKING := \
	XRBodyTracker.JOINT_FLAG_ORIENTATION_TRACKED | \
	XRBodyTracker.JOINT_FLAG_ORIENTATION_VALID | \
	XRBodyTracker.JOINT_FLAG_POSITION_TRACKED | \
	XRBodyTracker.JOINT_FLAG_POSITION_VALID


# OSC reader instance
var _osc_reader : OSCReader = OSCReader.new()

# Face tracker instance to publish tracking data
var _face_tracker : XRFaceTracker = XRFaceTracker.new()

# Body tracker instance to publish tracking data
var _body_tracker : XRBodyTracker = XRBodyTracker.new()

# Position mode
var _position_mode : PositionMode = PositionMode.FREE

# Array of joint relative positions
var _rel_positions : Array[Vector3] = []

# Array of joint relative rotations
var _rel_rotations : Array[Quaternion] = []

# Array of joint absolute positions
var _abs_positions : Array[Vector3] = []

# Array of joint absolute rotations
var _abs_rotations : Array[Quaternion] = []

# Array of face blends
var _face_blends : Array[float] = []

# Position calibration
var _position_calibration : Vector3 = Vector3.ZERO

# True if new joint data available
var _new_joints : bool = false

# True if new face blend data available
var _new_face_blends : bool = false

# Calibrated flag
var _position_calibrated : bool = false


# On initialization, construct and register the face and body trackers and
# start listening for incoming packets.
func _init(
	face_tracker_name : String,
	body_tracker_name : String,
	position_mode : int,
	udp_listener_port : int) -> void:

	# Fill the position and rotation arrays
	_rel_positions.resize(VMCBody.Joint.COUNT)
	_rel_rotations.resize(VMCBody.Joint.COUNT)
	_abs_positions.resize(VMCBody.Joint.COUNT)
	_abs_rotations.resize(VMCBody.Joint.COUNT)
	_rel_positions.fill(Vector3.ZERO)
	_rel_rotations.fill(Quaternion.IDENTITY)
	_abs_positions.fill(Vector3.ZERO)
	_abs_rotations.fill(Quaternion.IDENTITY)

	# Fill the face blend array
	_face_blends.resize(VMCBody.FaceBlend.COUNT)
	_face_blends.fill(0.0)

	# Register the face tracker
	_face_tracker.name = face_tracker_name
	XRServer.add_tracker(_face_tracker)

	# Register the body tracker
	_body_tracker.name = body_tracker_name
	XRServer.add_tracker(_body_tracker)

	# Save the position mode
	_position_mode = position_mode


	# Start listening for VMC packets
	_osc_reader.on_osc_packet.connect(_on_osc_packet)
	_osc_reader.listen(udp_listener_port)


# Poll for incoming packets
func poll() -> void:
	_osc_reader.poll()


# Handle received OSC packet data
func _on_osc_packet(data : Array) -> void:
	# Process all OSC entries
	for entry in data:
		match entry[0]:
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


# Handle a VMC bone position
func _on_vmc_ext_bone_pos(entry : Array) -> void:
	# Get the VMC joint
	var joint : VMCBody.Joint = VMCBody.JOINT_NAMES.get(entry[1], -1)
	if joint < 0:
		return

	# Save the relative positions and rotations
	var pos := Vector3(entry[2], entry[3], -entry[4])
	var rot := Quaternion(entry[5], entry[6], -entry[7], -entry[8])

	# If hips then consider position calibration
	if joint == VMCBody.Joint.HIPS:
		match _position_mode:
			PositionMode.CALIBRATE:
				# Calibrate on first position
				if not _position_calibrated:
					_position_calibrated = true
					_position_calibration = pos.slide(Vector3.UP)

				# Apply calibration
				pos -= _position_calibration

			PositionMode.LOCKED:
				# Project position to vertical axis
				pos = pos.project(Vector3.UP)

	# Save the joint
	_rel_positions[joint] = pos
	_rel_rotations[joint] = rot
	_new_joints = true


# Handle a VMC face blend value
func _on_vmc_ext_blend_val(entry : Array) -> void:
	# Get the VMC face blend
	var blend : VMCBody.FaceBlend = VMCBody.FACE_BLEND_NAMES.get(entry[1], -1)
	if blend < 0:
		return

	# Save the face blend
	_face_blends[blend] = entry[2]
	_new_face_blends = true


# Process VMC joint data into XRBodyTracker data
func _process_joints() -> void:
	# Iterate over the joints
	for joint in VMCBody.Joint.COUNT:
		# Get the joint information and relative location
		var parent_joint := VMCBody.JOINT_PARENT[joint]
		var pos := _rel_positions[joint]
		var rot := _rel_rotations[joint]

		# If child-joint then convert relative to absolute
		if parent_joint >= 0:
			var parent_pos := _abs_positions[parent_joint]
			var parent_rot := _abs_rotations[parent_joint]
			pos = parent_pos + parent_rot * pos
			rot = parent_rot * rot

		# Save absolute position
		_abs_positions[joint] = pos
		_abs_rotations[joint] = rot

	# Apply to the XRBodyTracker
	for joint in VMCBody.JOINT_MAPPING:
		var body : XRBodyTracker.Joint = joint["body"]
		var vmc : VMCBody.Joint = joint["native"]
		var roll : Quaternion = joint["roll"]

		# Set the joint transform
		_body_tracker.set_joint_transform(
			body,
			Transform3D(
				Basis(_abs_rotations[vmc] * roll),
				_abs_positions[vmc]))

		# Set the joint flags
		_body_tracker.set_joint_flags(body, JOINT_TRACKING)

	# Get the hips transform
	var hips := _body_tracker.get_joint_transform(XRBodyTracker.JOINT_HIPS)

	# Construct the root under the hips pointing forwards
	var root_y = Vector3.UP
	var root_z = -hips.basis.x.cross(root_y)
	var root_x = root_y.cross(root_z)
	var root_o := hips.origin.slide(Vector3.UP)
	var root := Transform3D(root_x, root_y, root_z, root_o).orthonormalized()
	_body_tracker.set_joint_transform(XRBodyTracker.JOINT_ROOT, root)
	_body_tracker.set_joint_flags(XRBodyTracker.JOINT_ROOT, JOINT_TRACKING)
	_body_tracker.set_pose("default", root, Vector3.ZERO, Vector3.ZERO, XRPose.XR_TRACKING_CONFIDENCE_HIGH);

	# Indicate we are tracking the body
	_body_tracker.body_flags = BODY_TRACKING
	_body_tracker.has_tracking_data = true


# Process VMC face blend data into XRFaceTracker
func _process_face_blends() -> void:
	# Apply to the XRFaceTracker
	for blend in VMCBody.FACE_BLEND_MAPPING:
		var face : Array = blend["face"]
		var vmc : Array = blend["native"]

		var weight := 0.0
		for v in vmc:
			weight += _face_blends[v]
		weight /= vmc.size()

		# Set the face blend weight
		for f in face:
			_face_tracker.set_blend_shape(f, weight)
