class_name VMCBody


## Constants for VMC Body
##
## This script contains the definition required to interpret the VMC body
## and translate it to XRBodyTracker and XRFaceTracker format.


## Enumeration of VMC joints
enum Joint {
	HIPS = 0,
	SPINE = 1,
	CHEST = 2,
	UPPER_CHEST = 3,
	NECK = 4,
	HEAD = 5,
	LEFT_EYE = 6,
	RIGHT_EYE = 7,
	JAW = 8,
	LEFT_UPPER_LEG = 9,
	LEFT_LOWER_LEG = 10,
	LEFT_FOOT = 11,
	LEFT_TOES = 12,
	RIGHT_UPPER_LEG = 13,
	RIGHT_LOWER_LEG = 14,
	RIGHT_FOOT = 15,
	RIGHT_TOES = 16,
	LEFT_SHOULDER = 17,
	LEFT_UPPER_ARM = 18,
	LEFT_LOWER_ARM = 19,
	LEFT_HAND = 20,
	RIGHT_SHOULDER = 21,
	RIGHT_UPPER_ARM = 22,
	RIGHT_LOWER_ARM = 23,
	RIGHT_HAND = 24,
	LEFT_THUMB_PROXIMAL = 25,
	LEFT_THUMB_INTERMEDIATE = 26,
	LEFT_THUMB_DISTAL = 27,
	LEFT_INDEX_PROXIMAL = 28,
	LEFT_INDEX_INTERMEDIATE = 29,
	LEFT_INDEX_DISTAL = 30,
	LEFT_MIDDLE_PROXIMAL = 31,
	LEFT_MIDDLE_INTERMEDIATE = 32,
	LEFT_MIDDLE_DISTAL = 33,
	LEFT_RING_PROXIMAL = 34,
	LEFT_RING_INTERMEDIATE = 35,
	LEFT_RING_DISTAL = 36,
	LEFT_LITTLE_PROXIMAL = 37,
	LEFT_LITTLE_INTERMEDIATE = 38,
	LEFT_LITTLE_DISTAL = 39,
	RIGHT_THUMB_PROXIMAL = 40,
	RIGHT_THUMB_INTERMEDIATE = 41,
	RIGHT_THUMB_DISTAL = 42,
	RIGHT_INDEX_PROXIMAL = 43,
	RIGHT_INDEX_INTERMEDIATE = 44,
	RIGHT_INDEX_DISTAL = 45,
	RIGHT_MIDDLE_PROXIMAL = 46,
	RIGHT_MIDDLE_INTERMEDIATE = 47,
	RIGHT_MIDDLE_DISTAL = 48,
	RIGHT_RING_PROXIMAL = 49,
	RIGHT_RING_INTERMEDIATE = 50,
	RIGHT_RING_DISTAL = 51,
	RIGHT_LITTLE_PROXIMAL = 52,
	RIGHT_LITTLE_INTERMEDIATE = 53,
	RIGHT_LITTLE_DISTAL = 54,
	COUNT = 55
}

## Enumeration of VMC face blends
enum FaceBlend {
	EYE_LOOK_UP_LEFT = 0,
	EYE_LOOK_UP_RIGHT = 1,
	EYE_LOOK_DOWN_LEFT = 2,
	EYE_LOOK_DOWN_RIGHT = 3,
	EYE_LOOK_IN_LEFT = 4,
	EYE_LOOK_IN_RIGHT = 5,
	EYE_LOOK_OUT_LEFT = 6,
	EYE_LOOK_OUT_RIGHT = 7,
	EYE_BLINK_LEFT = 8,
	EYE_BLINK_RIGHT = 9,
	EYE_SQUINT_LEFT = 10,
	EYE_SQUINT_RIGHT = 11,
	EYE_WIDE_LEFT = 12,
	EYE_WIDE_RIGHT = 13,
	BROW_DOWN_LEFT = 14,
	BROW_DOWN_RIGHT = 15,
	BROW_INNER_UP = 16,
	BROW_OUTER_UP_LEFT = 17,
	BROW_OUTER_UP_RIGHT = 18,
	NOSE_SNEER_LEFT = 19,
	NOSE_SNEER_RIGHT = 20,
	CHEEK_SQUINT_LEFT = 21,
	CHEEK_SQUINT_RIGHT = 22,
	CHEEK_PUFF = 23,
	JAW_OPEN = 24,
	MOUTH_CLOSE = 25,
	JAW_RIGHT = 26,
	JAW_LEFT = 27,
	JAW_FORWARD = 28,
	MOUTH_ROLL_UPPER = 29,
	MOUTH_ROLL_LOWER = 30,
	MOUTH_FUNNEL = 31,
	MOUTH_PUCKER = 32,
	MOUTH_UPPER_UP_LEFT = 33,
	MOUTH_UPPER_UP_RIGHT = 34,
	MOUTH_LOWER_DOWN_LEFT = 35,
	MOUTH_LOWER_DOWN_RIGHT = 36,
	MOUTH_SMILE_LEFT = 37,
	MOUTH_SMILE_RIGHT = 38,
	MOUTH_FROWN_LEFT = 39,
	MOUTH_FROWN_RIGHT = 40,
	MOUTH_STRETCH_LEFT = 41,
	MOUTH_STRETCH_RIGHT = 42,
	MOUTH_DIMPLE_LEFT = 43,
	MOUTH_DIMPLE_RIGHT = 44,
	MOUTH_SHRUG_UPPER = 45,
	MOUTH_SHRUG_LOWER = 46,
	MOUTH_PRESS_LEFT = 47,
	MOUTH_PRESS_RIGHT = 48,
	TONGUE_OUT = 49,
	COUNT = 50
}

## Dictionary of VMC Joint names to joints
const JointNames := {
	&"Hips" : Joint.HIPS,
	&"Spine" : Joint.SPINE,
	&"Chest" : Joint.CHEST,
	&"UpperChest" : Joint.UPPER_CHEST,
	&"Neck" : Joint.NECK,
	&"Head" : Joint.HEAD,
	&"LeftEye" : Joint.LEFT_EYE,
	&"RightEye" : Joint.RIGHT_EYE,
	&"Jaw" : Joint.JAW,
	&"LeftUpperLeg" : Joint.LEFT_UPPER_LEG,
	&"LeftLowerLeg" : Joint.LEFT_LOWER_LEG,
	&"LeftFoot" : Joint.LEFT_FOOT,
	&"LeftToes" : Joint.LEFT_TOES,
	&"RightUpperLeg" : Joint.RIGHT_UPPER_LEG,
	&"RightLowerLeg" : Joint.RIGHT_LOWER_LEG,
	&"RightFoot" : Joint.RIGHT_FOOT,
	&"RightToes" : Joint.RIGHT_TOES,
	&"LeftShoulder" : Joint.LEFT_SHOULDER,
	&"LeftUpperArm" : Joint.LEFT_UPPER_ARM,
	&"LeftLowerArm" : Joint.LEFT_LOWER_ARM,
	&"LeftHand" : Joint.LEFT_HAND,
	&"RightShoulder" : Joint.RIGHT_SHOULDER,
	&"RightUpperArm" : Joint.RIGHT_UPPER_ARM,
	&"RightLowerArm" : Joint.RIGHT_LOWER_ARM,
	&"RightHand" : Joint.RIGHT_HAND,
	&"LeftThumbProximal" : Joint.LEFT_THUMB_PROXIMAL,
	&"LeftThumbIntermediate" : Joint.LEFT_THUMB_INTERMEDIATE,
	&"LeftThumbDistal" : Joint.LEFT_THUMB_DISTAL,
	&"LeftIndexProximal" : Joint.LEFT_INDEX_PROXIMAL,
	&"LeftIndexIntermediate" : Joint.LEFT_INDEX_INTERMEDIATE,
	&"LeftIndexDistal" : Joint.LEFT_INDEX_DISTAL,
	&"LeftMiddleProximal" : Joint.LEFT_MIDDLE_PROXIMAL,
	&"LeftMiddleIntermediate" : Joint.LEFT_MIDDLE_INTERMEDIATE,
	&"LeftMiddleDistal" : Joint.LEFT_MIDDLE_DISTAL,
	&"LeftRingProximal" : Joint.LEFT_RING_PROXIMAL,
	&"LeftRingIntermediate" : Joint.LEFT_RING_INTERMEDIATE,
	&"LeftRingDistal" : Joint.LEFT_RING_DISTAL,
	&"LeftLittleProximal" : Joint.LEFT_LITTLE_PROXIMAL,
	&"LeftLittleIntermediate" : Joint.LEFT_LITTLE_INTERMEDIATE,
	&"LeftLittleDistal" : Joint.LEFT_LITTLE_DISTAL,
	&"RightThumbProximal" : Joint.RIGHT_THUMB_PROXIMAL,
	&"RightThumbIntermediate" : Joint.RIGHT_THUMB_INTERMEDIATE,
	&"RightThumbDistal" : Joint.RIGHT_THUMB_DISTAL,
	&"RightIndexProximal" : Joint.RIGHT_INDEX_PROXIMAL,
	&"RightIndexIntermediate" : Joint.RIGHT_INDEX_INTERMEDIATE,
	&"RightIndexDistal" : Joint.RIGHT_INDEX_DISTAL,
	&"RightMiddleProximal" : Joint.RIGHT_MIDDLE_PROXIMAL,
	&"RightMiddleIntermediate" : Joint.RIGHT_MIDDLE_INTERMEDIATE,
	&"RightMiddleDistal" : Joint.RIGHT_MIDDLE_DISTAL,
	&"RightRingProximal" : Joint.RIGHT_RING_PROXIMAL,
	&"RightRingIntermediate" : Joint.RIGHT_RING_INTERMEDIATE,
	&"RightRingDistal" : Joint.RIGHT_RING_DISTAL,
	&"RightLittleProximal" : Joint.RIGHT_LITTLE_PROXIMAL,
	&"RightLittleIntermediate" : Joint.RIGHT_LITTLE_INTERMEDIATE,
	&"RightLittleDistal" : Joint.RIGHT_LITTLE_DISTAL
}

## Dictionary of VMC Face Blend names to face blends
const FaceBlendNames := {
	&"EyeLookUpLeft" : FaceBlend.EYE_LOOK_UP_LEFT,
	&"EyeLookUpRight" : FaceBlend.EYE_LOOK_UP_RIGHT,
	&"EyeLookDownLeft" : FaceBlend.EYE_LOOK_DOWN_LEFT,
	&"EyeLookDownRight" : FaceBlend.EYE_LOOK_DOWN_RIGHT,
	&"EyeLookInLeft" : FaceBlend.EYE_LOOK_IN_LEFT,
	&"EyeLookInRight" : FaceBlend.EYE_LOOK_IN_RIGHT,
	&"EyeLookOutLeft" : FaceBlend.EYE_LOOK_OUT_LEFT,
	&"EyeLookOutRight" : FaceBlend.EYE_LOOK_OUT_RIGHT,
	&"EyeBlinkLeft" : FaceBlend.EYE_BLINK_LEFT,
	&"EyeBlinkRight" : FaceBlend.EYE_BLINK_RIGHT,
	&"EyeSquintLeft" : FaceBlend.EYE_SQUINT_LEFT,
	&"EyeSquintRight" : FaceBlend.EYE_SQUINT_RIGHT,
	&"EyeWideLeft" : FaceBlend.EYE_WIDE_LEFT,
	&"EyeWideRight" : FaceBlend.EYE_WIDE_RIGHT,
	&"BrowDownLeft" : FaceBlend.BROW_DOWN_LEFT,
	&"BrowDownRight" : FaceBlend.BROW_DOWN_RIGHT,
	&"BrowInnerUp" : FaceBlend.BROW_INNER_UP,
	&"BrowOuterUpLeft" : FaceBlend.BROW_OUTER_UP_LEFT,
	&"BrowOuterUpRight" : FaceBlend.BROW_OUTER_UP_RIGHT,
	&"NoseSneerLeft" : FaceBlend.NOSE_SNEER_LEFT,
	&"NoseSneerRight" : FaceBlend.NOSE_SNEER_RIGHT,
	&"CheekSquintLeft" : FaceBlend.CHEEK_SQUINT_LEFT,
	&"CheekSquintRight" : FaceBlend.CHEEK_SQUINT_RIGHT,
	&"CheekPuff" : FaceBlend.CHEEK_PUFF,
	&"JawOpen" : FaceBlend.JAW_OPEN,
	&"MouthClose" : FaceBlend.MOUTH_CLOSE,
	&"JawRight" : FaceBlend.JAW_RIGHT,
	&"JawLeft" : FaceBlend.JAW_LEFT,
	&"JawForward" : FaceBlend.JAW_FORWARD,
	&"MouthRollUpper" : FaceBlend.MOUTH_ROLL_UPPER,
	&"MouthRollLower" : FaceBlend.MOUTH_ROLL_LOWER,
	&"MouthFunnel" : FaceBlend.MOUTH_FUNNEL,
	&"MouthPucker" : FaceBlend.MOUTH_PUCKER,
	&"MouthUpperUpLeft" : FaceBlend.MOUTH_UPPER_UP_LEFT,
	&"MouthUpperUpRight" : FaceBlend.MOUTH_UPPER_UP_RIGHT,
	&"MouthLowerDownLeft" : FaceBlend.MOUTH_LOWER_DOWN_LEFT,
	&"MouthLowerDownRight" : FaceBlend.MOUTH_LOWER_DOWN_RIGHT,
	&"MouthSmileLeft" : FaceBlend.MOUTH_SMILE_LEFT,
	&"MouthSmileRight" : FaceBlend.MOUTH_SMILE_RIGHT,
	&"MouthFrownLeft" : FaceBlend.MOUTH_FROWN_LEFT,
	&"MouthFrownRight" : FaceBlend.MOUTH_FROWN_RIGHT,
	&"MouthStretchLeft" : FaceBlend.MOUTH_STRETCH_LEFT,
	&"MouthStretchRight" : FaceBlend.MOUTH_STRETCH_RIGHT,
	&"MouthDimpleLeft" : FaceBlend.MOUTH_DIMPLE_LEFT,
	&"MouthDimpleRight" : FaceBlend.MOUTH_DIMPLE_RIGHT,
	&"MouthShrugUpper" : FaceBlend.MOUTH_SHRUG_UPPER,
	&"MouthShrugLower" : FaceBlend.MOUTH_SHRUG_LOWER,
	&"MouthPressLeft" : FaceBlend.MOUTH_PRESS_LEFT,
	&"MouthPressRight" : FaceBlend.MOUTH_PRESS_RIGHT,
	&"TongueOut" : FaceBlend.TONGUE_OUT,
}

## VMC Joint Parent relationship
const JointParent : Array[Joint] = [
	-1,								# 0: Joint.HIPS
	Joint.HIPS,						# 1: Joint.SPINE
	Joint.SPINE,					# 2: Joint.CHEST
	Joint.CHEST,					# 3: Joint.UPPER_CHEST
	Joint.UPPER_CHEST,				# 4: Joint.NECK
	Joint.NECK,						# 5: Joint.HEAD
	Joint.HEAD,						# 6: Joint.LEFT_EYE
	Joint.HEAD,						# 7: Joint.RIGHT_EYE
	Joint.HEAD,						# 8: Joint.JAW
	Joint.HIPS,						# 9: Joint.LEFT_UPPER_LEG
	Joint.LEFT_UPPER_LEG,			# 10: Joint.LEFT_LOWER_LEG
	Joint.LEFT_LOWER_LEG,			# 11: Joint.LEFT_FOOT
	Joint.LEFT_FOOT,				# 12: Joint.LEFT_TOES
	Joint.HIPS,						# 13: Joint.RIGHT_UPPER_LEG
	Joint.RIGHT_UPPER_LEG,			# 14: Joint.RIGHT_LOWER_LEG
	Joint.RIGHT_LOWER_LEG,			# 15: Joint.RIGHT_FOOT
	Joint.RIGHT_FOOT,				# 16: Joint.RIGHT_TOES
	Joint.UPPER_CHEST,				# 17: Joint.LEFT_SHOULDER
	Joint.LEFT_SHOULDER,			# 18: Joint.LEFT_UPPER_ARM
	Joint.LEFT_UPPER_ARM,			# 19: Joint.LEFT_LOWER_ARM
	Joint.LEFT_LOWER_ARM,			# 20: Joint.LEFT_HAND
	Joint.UPPER_CHEST,				# 21: Joint.RIGHT_SHOULDER
	Joint.RIGHT_SHOULDER,			# 22: Joint.RIGHT_UPPER_ARM
	Joint.RIGHT_UPPER_ARM,			# 23: Joint.RIGHT_LOWER_ARM
	Joint.RIGHT_LOWER_ARM,			# 24: Joint.RIGHT_HAND
	Joint.LEFT_HAND,				# 25: Joint.LEFT_THUMB_PROXIMAL
	Joint.LEFT_THUMB_PROXIMAL,		# 26: Joint.LEFT_THUMB_INTERMEDIATE
	Joint.LEFT_THUMB_INTERMEDIATE,	# 27: Joint.LEFT_THUMB_DISTAL
	Joint.LEFT_HAND,				# 28: Joint.LEFT_INDEX_PROXIMAL
	Joint.LEFT_INDEX_PROXIMAL,		# 29: Joint.LEFT_INDEX_INTERMEDIATE
	Joint.LEFT_INDEX_INTERMEDIATE,	# 30: Joint.LEFT_INDEX_DISTAL
	Joint.LEFT_HAND,				# 31: Joint.LEFT_MIDDLE_PROXIMAL
	Joint.LEFT_MIDDLE_PROXIMAL,		# 32: Joint.LEFT_MIDDLE_INTERMEDIATE
	Joint.LEFT_MIDDLE_INTERMEDIATE,	# 33: Joint.LEFT_MIDDLE_DISTAL
	Joint.LEFT_HAND,				# 34: Joint.LEFT_RING_PROXIMAL
	Joint.LEFT_RING_PROXIMAL,		# 35: Joint.LEFT_RING_INTERMEDIATE
	Joint.LEFT_RING_INTERMEDIATE,	# 36: Joint.LEFT_RING_DISTAL
	Joint.LEFT_HAND,				# 37: Joint.LEFT_LITTLE_PROXIMAL
	Joint.LEFT_LITTLE_PROXIMAL,		# 38: Joint.LEFT_LITTLE_INTERMEDIATE
	Joint.LEFT_LITTLE_INTERMEDIATE,	# 39: Joint.LEFT_LITTLE_DISTAL
	Joint.RIGHT_HAND,				# 40: Joint.RIGHT_THUMB_PROXIMAL
	Joint.RIGHT_THUMB_PROXIMAL,		# 41: Joint.RIGHT_THUMB_INTERMEDIATE
	Joint.RIGHT_THUMB_INTERMEDIATE,	# 42: Joint.RIGHT_THUMB_DISTAL
	Joint.RIGHT_HAND,				# 43: Joint.RIGHT_INDEX_PROXIMAL
	Joint.RIGHT_INDEX_PROXIMAL,		# 44: Joint.RIGHT_INDEX_INTERMEDIATE
	Joint.RIGHT_INDEX_INTERMEDIATE,	# 45: Joint.RIGHT_INDEX_DISTAL
	Joint.RIGHT_HAND,				# 46: Joint.RIGHT_MIDDLE_PROXIMAL
	Joint.RIGHT_MIDDLE_PROXIMAL,	# 47: Joint.RIGHT_MIDDLE_INTERMEDIATE
	Joint.RIGHT_MIDDLE_INTERMEDIATE,# 48: Joint.RIGHT_MIDDLE_DISTAL
	Joint.RIGHT_HAND,				# 49: Joint.RIGHT_RING_PROXIMAL
	Joint.RIGHT_RING_PROXIMAL,		# 50: Joint.RIGHT_RING_INTERMEDIATE
	Joint.RIGHT_RING_INTERMEDIATE,	# 51: Joint.RIGHT_RING_DISTAL
	Joint.RIGHT_HAND,				# 52: Joint.RIGHT_LITTLE_PROXIMAL
	Joint.RIGHT_LITTLE_PROXIMAL,	# 53: Joint.RIGHT_LITTLE_INTERMEDIATE
	Joint.RIGHT_LITTLE_INTERMEDIATE,# 54: Joint.RIGHT_LITTLE_DISTAL
]

## Mapping of XRBodyTracker joints to VMC joints
const JointMapping : Array[Dictionary] = [
	# Upper Body Joints
	{
		body = XRBodyTracker.JOINT_HIPS,
		vmc = Joint.HIPS,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_SPINE,
		vmc = Joint.SPINE,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_CHEST,
		vmc = Joint.CHEST,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_UPPER_CHEST,
		vmc = Joint.UPPER_CHEST,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_NECK,
		vmc = Joint.NECK,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_HEAD,
		vmc = Joint.HEAD,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_SHOULDER,
		vmc = Joint.LEFT_SHOULDER,
		roll = Quaternion(-0.5, 0.5, 0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_UPPER_ARM,
		vmc = Joint.LEFT_UPPER_ARM,
		roll = Quaternion(0.5, -0.5, 0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_LOWER_ARM,
		vmc = Joint.LEFT_LOWER_ARM,
		roll = Quaternion(-0.7071068, 0.7071068, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_SHOULDER,
		vmc = Joint.RIGHT_SHOULDER,
		roll = Quaternion(0.5, 0.5, 0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_UPPER_ARM,
		vmc = Joint.RIGHT_UPPER_ARM,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_LOWER_ARM,
		vmc = Joint.RIGHT_LOWER_ARM,
		roll = Quaternion(0.7071068, 0.7071068, 0.0, 0.0)
	},

	# Lower Body Joints
	{
		body = XRBodyTracker.JOINT_LEFT_UPPER_LEG,
		vmc = Joint.LEFT_UPPER_LEG,
		roll = Quaternion(1.0, 0.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_LOWER_LEG,
		vmc = Joint.LEFT_LOWER_LEG,
		roll = Quaternion(0.0, 0.0, 1.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_FOOT,
		vmc = Joint.LEFT_FOOT,
		roll = Quaternion(-0.7071068, 0.0, 0.0, 0.7071068)
	},
	#{
	#	body = XRBodyTracker.JOINT_LEFT_TOES,
	#	vmc = Joint.LEFT_TOES,
	#	roll = Quaternion(-0.7071068, 0.0, 0.0, 0.7071068)
	#},
	{
		body = XRBodyTracker.JOINT_RIGHT_UPPER_LEG,
		vmc = Joint.RIGHT_UPPER_LEG,
		roll = Quaternion(1.0, 0.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_LOWER_LEG,
		vmc = Joint.RIGHT_LOWER_LEG,
		roll = Quaternion(0.0, 0.0, 1.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_FOOT,
		vmc = Joint.RIGHT_FOOT,
		roll = Quaternion(-0.7071068, 0.0, 0.0, 0.7071068)
	},
	#{
	#	body = XRBodyTracker.JOINT_RIGHT_TOES,
	#	vmc = Joint.RIGHT_TOES,
	#	roll = Quaternion(-0.7071068, 0.0, 0.0, 0.7071068)
	#},

	# Left Hand Joints
	{
		body = XRBodyTracker.JOINT_LEFT_HAND,
		vmc = Joint.LEFT_HAND,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_WRIST,
		vmc = Joint.LEFT_HAND,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_THUMB_METACARPAL,
		vmc = Joint.LEFT_THUMB_PROXIMAL,
		roll = Quaternion(0.3535534, -0.6123724, 0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_THUMB_PHALANX_PROXIMAL,
		vmc = Joint.LEFT_THUMB_INTERMEDIATE,
		roll = Quaternion(0.3535534, -0.6123724, 0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_THUMB_PHALANX_DISTAL,
		vmc = Joint.LEFT_THUMB_DISTAL,
		roll = Quaternion(0.3535534, -0.6123724, 0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_INDEX_FINGER_PHALANX_PROXIMAL,
		vmc = Joint.LEFT_INDEX_PROXIMAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_INDEX_FINGER_PHALANX_INTERMEDIATE,
		vmc = Joint.LEFT_INDEX_INTERMEDIATE,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_INDEX_FINGER_PHALANX_DISTAL,
		vmc = Joint.LEFT_INDEX_DISTAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_MIDDLE_FINGER_PHALANX_PROXIMAL,
		vmc = Joint.LEFT_MIDDLE_PROXIMAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_MIDDLE_FINGER_PHALANX_INTERMEDIATE,
		vmc = Joint.LEFT_MIDDLE_INTERMEDIATE,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_MIDDLE_FINGER_PHALANX_DISTAL,
		vmc = Joint.LEFT_MIDDLE_DISTAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_RING_FINGER_PHALANX_PROXIMAL,
		vmc = Joint.LEFT_RING_PROXIMAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_RING_FINGER_PHALANX_INTERMEDIATE,
		vmc = Joint.LEFT_RING_INTERMEDIATE,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_RING_FINGER_PHALANX_DISTAL,
		vmc = Joint.LEFT_RING_DISTAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_PINKY_FINGER_PHALANX_PROXIMAL,
		vmc = Joint.LEFT_LITTLE_PROXIMAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_PINKY_FINGER_PHALANX_INTERMEDIATE,
		vmc = Joint.LEFT_LITTLE_INTERMEDIATE,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_PINKY_FINGER_PHALANX_DISTAL,
		vmc = Joint.LEFT_LITTLE_DISTAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},

	# Right Hand Joints
	{
		body = XRBodyTracker.JOINT_RIGHT_HAND,
		vmc = Joint.RIGHT_HAND,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_WRIST,
		vmc = Joint.RIGHT_HAND,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_THUMB_METACARPAL,
		vmc = Joint.RIGHT_THUMB_PROXIMAL,
		roll = Quaternion(0.3535534, 0.6123724, -0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_THUMB_PHALANX_PROXIMAL,
		vmc = Joint.RIGHT_THUMB_INTERMEDIATE,
		roll = Quaternion(0.3535534, 0.6123724, -0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_THUMB_PHALANX_DISTAL,
		vmc = Joint.RIGHT_THUMB_DISTAL,
		roll = Quaternion(0.3535534, 0.6123724, -0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_INDEX_FINGER_PHALANX_PROXIMAL,
		vmc = Joint.RIGHT_INDEX_PROXIMAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_INDEX_FINGER_PHALANX_INTERMEDIATE,
		vmc = Joint.RIGHT_INDEX_INTERMEDIATE,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_INDEX_FINGER_PHALANX_DISTAL,
		vmc = Joint.RIGHT_INDEX_DISTAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_MIDDLE_FINGER_PHALANX_PROXIMAL,
		vmc = Joint.RIGHT_MIDDLE_PROXIMAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_MIDDLE_FINGER_PHALANX_INTERMEDIATE,
		vmc = Joint.RIGHT_MIDDLE_INTERMEDIATE,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_MIDDLE_FINGER_PHALANX_DISTAL,
		vmc = Joint.RIGHT_MIDDLE_DISTAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_RING_FINGER_PHALANX_PROXIMAL,
		vmc = Joint.RIGHT_RING_PROXIMAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_RING_FINGER_PHALANX_INTERMEDIATE,
		vmc = Joint.RIGHT_RING_INTERMEDIATE,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_RING_FINGER_PHALANX_DISTAL,
		vmc = Joint.RIGHT_RING_DISTAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_PINKY_FINGER_PHALANX_PROXIMAL,
		vmc = Joint.RIGHT_LITTLE_PROXIMAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_PINKY_FINGER_PHALANX_INTERMEDIATE,
		vmc = Joint.RIGHT_LITTLE_INTERMEDIATE,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_PINKY_FINGER_PHALANX_DISTAL,
		vmc = Joint.RIGHT_LITTLE_DISTAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
]

## Mapping of XRFaceTracker blends to VMC face blends
const FaceBlendMapping : Array[Dictionary] = [
	# Upper Body Joints
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_OUT_RIGHT ],
		vmc = [ FaceBlend.EYE_LOOK_OUT_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_IN_RIGHT ],
		vmc = [ FaceBlend.EYE_LOOK_IN_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_UP_RIGHT ],
		vmc = [ FaceBlend.EYE_LOOK_UP_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_DOWN_RIGHT ],
		vmc = [ FaceBlend.EYE_LOOK_DOWN_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_OUT_LEFT ],
		vmc = [ FaceBlend.EYE_LOOK_OUT_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_IN_LEFT ],
		vmc = [ FaceBlend.EYE_LOOK_IN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_UP_LEFT ],
		vmc = [ FaceBlend.EYE_LOOK_UP_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_DOWN_LEFT ],
		vmc = [ FaceBlend.EYE_LOOK_DOWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_CLOSED_RIGHT ],
		vmc = [ FaceBlend.EYE_BLINK_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_CLOSED_LEFT ],
		vmc = [ FaceBlend.EYE_BLINK_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_CLOSED ],
		vmc = [ FaceBlend.EYE_BLINK_RIGHT,
				FaceBlend.EYE_BLINK_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_SQUINT_RIGHT ],
		vmc = [ FaceBlend.EYE_SQUINT_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_SQUINT_LEFT ],
		vmc = [ FaceBlend.EYE_SQUINT_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_SQUINT ],
		vmc = [ FaceBlend.EYE_SQUINT_RIGHT,
				FaceBlend.EYE_SQUINT_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_WIDE_RIGHT ],
		vmc = [ FaceBlend.EYE_WIDE_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_WIDE_LEFT ],
		vmc = [ FaceBlend.EYE_WIDE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_WIDE ],
		vmc = [ FaceBlend.EYE_WIDE_RIGHT,
				FaceBlend.EYE_WIDE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_BROW_DOWN_RIGHT ],
		vmc = [ FaceBlend.BROW_DOWN_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_BROW_DOWN_LEFT ],
		vmc = [ FaceBlend.BROW_DOWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_BROW_DOWN ],
		vmc = [ FaceBlend.BROW_DOWN_RIGHT,
				FaceBlend.BROW_DOWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_BROW_OUTER_UP_RIGHT ],
		vmc = [ FaceBlend.BROW_OUTER_UP_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_BROW_OUTER_UP_LEFT ],
		vmc = [ FaceBlend.BROW_OUTER_UP_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_NOSE_SNEER_RIGHT ],
		vmc = [ FaceBlend.NOSE_SNEER_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_NOSE_SNEER_LEFT ],
		vmc = [ FaceBlend.NOSE_SNEER_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_NOSE_SNEER ],
		vmc = [ FaceBlend.NOSE_SNEER_RIGHT,
				FaceBlend.NOSE_SNEER_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_CHEEK_SQUINT_RIGHT ],
		vmc = [ FaceBlend.CHEEK_SQUINT_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_CHEEK_SQUINT_LEFT ],
		vmc = [ FaceBlend.CHEEK_SQUINT_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_CHEEK_SQUINT ],
		vmc = [ FaceBlend.CHEEK_SQUINT_RIGHT,
				FaceBlend.CHEEK_SQUINT_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_CHEEK_PUFF,
				 XRFaceTracker.FT_CHEEK_PUFF_RIGHT,
				 XRFaceTracker.FT_CHEEK_PUFF_LEFT ],
		vmc = [ FaceBlend.CHEEK_PUFF ],
	},
	{
		face = [ XRFaceTracker.FT_JAW_OPEN ],
		vmc = [ FaceBlend.JAW_OPEN ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_CLOSED ],
		vmc = [ FaceBlend.MOUTH_CLOSE ],
	},
	{
		face = [ XRFaceTracker.FT_JAW_RIGHT ],
		vmc = [ FaceBlend.JAW_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_JAW_LEFT ],
		vmc = [ FaceBlend.JAW_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_JAW_FORWARD ],
		vmc = [ FaceBlend.JAW_FORWARD ],
	},
	{
		face = [ XRFaceTracker.FT_LIP_FUNNEL,
				 XRFaceTracker.FT_LIP_FUNNEL_UPPER,
				 XRFaceTracker.FT_LIP_FUNNEL_LOWER ],
		vmc = [ FaceBlend.MOUTH_FUNNEL ],
	},
	{
		face = [ XRFaceTracker.FT_LIP_PUCKER,
				 XRFaceTracker.FT_LIP_PUCKER_UPPER,
				 XRFaceTracker.FT_LIP_PUCKER_LOWER ],
		vmc = [ FaceBlend.MOUTH_PUCKER ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_UPPER_UP_RIGHT ],
		vmc = [ FaceBlend.MOUTH_UPPER_UP_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_UPPER_UP_LEFT ],
		vmc = [ FaceBlend.MOUTH_UPPER_UP_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_UPPER_UP ],
		vmc = [ FaceBlend.MOUTH_UPPER_UP_RIGHT,
				FaceBlend.MOUTH_UPPER_UP_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_LOWER_DOWN_RIGHT ],
		vmc = [ FaceBlend.MOUTH_LOWER_DOWN_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_LOWER_DOWN_LEFT ],
		vmc = [ FaceBlend.MOUTH_LOWER_DOWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_LOWER_DOWN ],
		vmc = [ FaceBlend.MOUTH_LOWER_DOWN_RIGHT,
				FaceBlend.MOUTH_LOWER_DOWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_SMILE_RIGHT ],
		vmc = [ FaceBlend.MOUTH_SMILE_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_SMILE_LEFT ],
		vmc = [ FaceBlend.MOUTH_SMILE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_SMILE ],
		vmc = [ FaceBlend.MOUTH_SMILE_RIGHT,
				FaceBlend.MOUTH_SMILE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_FROWN_RIGHT ],
		vmc = [ FaceBlend.MOUTH_FROWN_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_FROWN_LEFT ],
		vmc = [ FaceBlend.MOUTH_FROWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_STRETCH_RIGHT ],
		vmc = [ FaceBlend.MOUTH_STRETCH_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_STRETCH_LEFT ],
		vmc = [ FaceBlend.MOUTH_STRETCH_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_STRETCH ],
		vmc = [ FaceBlend.MOUTH_STRETCH_RIGHT,
				FaceBlend.MOUTH_STRETCH_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_DIMPLE_RIGHT ],
		vmc = [ FaceBlend.MOUTH_DIMPLE_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_DIMPLE_LEFT ],
		vmc = [ FaceBlend.MOUTH_DIMPLE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_DIMPLE ],
		vmc = [ FaceBlend.MOUTH_DIMPLE_RIGHT,
				FaceBlend.MOUTH_DIMPLE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_PRESS_RIGHT ],
		vmc = [ FaceBlend.MOUTH_PRESS_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_PRESS_LEFT ],
		vmc = [ FaceBlend.MOUTH_PRESS_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_PRESS ],
		vmc = [ FaceBlend.MOUTH_PRESS_RIGHT,
				FaceBlend.MOUTH_PRESS_LEFT ],
	},
]
