class_name OSCReader
extends Object


## OSC Reader Script
##
## This script implements a basic OSC packet reader. The listen method is used
## to start the UDP server. The poll method should be called to poll for
## incoming packets. Packets are decoded and dispatched through the
## on_osc_packet signal.


## OSC packet received signal
signal on_osc_packet(data : Array)


# UDP Server
var _server : UDPServer = UDPServer.new()

# Current connection
var _connection : PacketPeerUDP


## Stop listening
func stop() -> void:
	_server.stop()
	_connection = null


## Start listening
func listen(p_port : int = 39539) -> void:
	stop()
	_server.listen(p_port)


## Poll for incoming packets
func poll() -> void:
	# Poll the server
	_server.poll()

	# Switch to any new connection
	if _server.is_connection_available():
		_connection = _server.take_connection()

	# Skip if no connection
	if not _connection:
		return

	# Loop processing the incoming packets
	while _connection.get_available_packet_count() > 0:
		# Read the packet
		var packet := StreamPeerBuffer.new()
		packet.big_endian = true
		packet.data_array = _connection.get_packet()

		# Read the packet
		var data := []
		_read_osc_message_bundle(packet, data)

		# Dispatch the data
		on_osc_packet.emit(data)


# Read an OSC message or bundle
func _read_osc_message_bundle(packet : StreamPeerBuffer, data : Array) -> void:
	# Inspect the data item
	var type := packet.data_array[packet.get_position()]
	match type:
		47:		# '/' character starting OSC message
			_read_osc_message(packet, data)

		35:		# '#' character starting OSC bundle
			_read_osc_bundle(packet, data)


# Read an OSC message
func _read_osc_message(packet : StreamPeerBuffer, data : Array) -> void:
	var values := []
	values.append(_read_osc_string(packet))
	var type := _read_osc_string(packet)
	for ch in type:
		match ch:
			"i":
				values.append(packet.get_32())
			"f":
				values.append(packet.get_float())
			"s":
				values.append(_read_osc_string(packet))
			"b":
				values.append(_read_osc_blob(packet))

	data.append(values)


# Read an OSC bundle
func _read_osc_bundle(packet : StreamPeerBuffer, data : Array) -> void:
	var bundle := _read_osc_string(packet)
	var time := packet.get_64()

	while packet.get_available_bytes() > 4:
		_read_osc_bundle_element(packet, data)


# Read an OSC bundle element
func _read_osc_bundle_element(packet : StreamPeerBuffer, data : Array) -> void:
	var size := packet.get_32()
	_read_osc_message_bundle(packet, data)


# Read an OSC string
func _read_osc_string(packet : StreamPeerBuffer) -> String:
	# Find the end of the string
	var pos := packet.get_position()
	var end := packet.data_array.find(0, pos)
	if end < 0:
		return "";

	# Read the string
	var value := packet.get_string(end - pos)

	# Seek past the null(s)
	packet.seek((end + 4) & ~3)

	# Return the string
	return value


# Read an OSC blob
static func _read_osc_blob(packet : StreamPeerBuffer) -> PackedByteArray:
	# Read the size
	var size := packet.get_32()

	# Read the data
	var data := packet.get_data(size)

	# Seek past the null padding
	packet.seek((packet.get_position() + 3) & ~3)

	# Return the blob
	return data[1]
