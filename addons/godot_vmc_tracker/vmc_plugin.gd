extends Node


## VMC Plugin Node
##
## This node provides a VMC tracker as a plugin autoload singleton.


# Tracker source
var _source : VMCSource


# On entering the scene-tree, construct the tracker source and start listening
# for incoming packets.
func _enter_tree() -> void:
	# Get the face tracker name
	var face_tracker_name : String = ProjectSettings.get_setting(
		"godot_vmc_tracker/tracking/face_tracker_name",
		"/vmc/face_tracker")

	# Get the body tracker name
	var body_tracker_name : String = ProjectSettings.get_setting(
		"godot_vmc_tracker/tracking/body_tracker_name",
		"/vmc/body_tracker")

	# Get the position mode
	var position_mode = ProjectSettings.get_setting(
		"godot_vmc_tracker/tracking/position_mode",
		0)

	# Get the UDP port number
	var udp_listener_port : int = ProjectSettings.get_setting(
		"godot_vmc_tracker/network/udp_listener_port",
		39539)

	_source = VMCSource.new(
		face_tracker_name,
		body_tracker_name,
		position_mode,
		udp_listener_port)


# On frame processing, poll the tracker source for updates.
func _process(_delta: float) -> void:
	_source.poll()
