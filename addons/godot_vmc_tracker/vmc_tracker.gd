extends Node


## VMC Reader Script
##
## This script reads VMC packets and uses the data to generate XRFaceTracker and
## XRBodyTracker data for driving avatars.


## Enumeration of VMC joints
enum VmcJoint {
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
enum VmcFaceBlend {
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
const VmcJointNames := {
	&"Hips" : VmcJoint.HIPS,
	&"Spine" : VmcJoint.SPINE,
	&"Chest" : VmcJoint.CHEST,
	&"UpperChest" : VmcJoint.UPPER_CHEST,
	&"Neck" : VmcJoint.NECK,
	&"Head" : VmcJoint.HEAD,
	&"LeftEye" : VmcJoint.LEFT_EYE,
	&"RightEye" : VmcJoint.RIGHT_EYE,
	&"Jaw" : VmcJoint.JAW,
	&"LeftUpperLeg" : VmcJoint.LEFT_UPPER_LEG,
	&"LeftLowerLeg" : VmcJoint.LEFT_LOWER_LEG,
	&"LeftFoot" : VmcJoint.LEFT_FOOT,
	&"LeftToes" : VmcJoint.LEFT_TOES,
	&"RightUpperLeg" : VmcJoint.RIGHT_UPPER_LEG,
	&"RightLowerLeg" : VmcJoint.RIGHT_LOWER_LEG,
	&"RightFoot" : VmcJoint.RIGHT_FOOT,
	&"RightToes" : VmcJoint.RIGHT_TOES,
	&"LeftShoulder" : VmcJoint.LEFT_SHOULDER,
	&"LeftUpperArm" : VmcJoint.LEFT_UPPER_ARM,
	&"LeftLowerArm" : VmcJoint.LEFT_LOWER_ARM,
	&"LeftHand" : VmcJoint.LEFT_HAND,
	&"RightShoulder" : VmcJoint.RIGHT_SHOULDER,
	&"RightUpperArm" : VmcJoint.RIGHT_UPPER_ARM,
	&"RightLowerArm" : VmcJoint.RIGHT_LOWER_ARM,
	&"RightHand" : VmcJoint.RIGHT_HAND,
	&"LeftThumbProximal" : VmcJoint.LEFT_THUMB_PROXIMAL,
	&"LeftThumbIntermediate" : VmcJoint.LEFT_THUMB_INTERMEDIATE,
	&"LeftThumbDistal" : VmcJoint.LEFT_THUMB_DISTAL,
	&"LeftIndexProximal" : VmcJoint.LEFT_INDEX_PROXIMAL,
	&"LeftIndexIntermediate" : VmcJoint.LEFT_INDEX_INTERMEDIATE,
	&"LeftIndexDistal" : VmcJoint.LEFT_INDEX_DISTAL,
	&"LeftMiddleProximal" : VmcJoint.LEFT_MIDDLE_PROXIMAL,
	&"LeftMiddleIntermediate" : VmcJoint.LEFT_MIDDLE_INTERMEDIATE,
	&"LeftMiddleDistal" : VmcJoint.LEFT_MIDDLE_DISTAL,
	&"LeftRingProximal" : VmcJoint.LEFT_RING_PROXIMAL,
	&"LeftRingIntermediate" : VmcJoint.LEFT_RING_INTERMEDIATE,
	&"LeftRingDistal" : VmcJoint.LEFT_RING_DISTAL,
	&"LeftLittleProximal" : VmcJoint.LEFT_LITTLE_PROXIMAL,
	&"LeftLittleIntermediate" : VmcJoint.LEFT_LITTLE_INTERMEDIATE,
	&"LeftLittleDistal" : VmcJoint.LEFT_LITTLE_DISTAL,
	&"RightThumbProximal" : VmcJoint.RIGHT_THUMB_PROXIMAL,
	&"RightThumbIntermediate" : VmcJoint.RIGHT_THUMB_INTERMEDIATE,
	&"RightThumbDistal" : VmcJoint.RIGHT_THUMB_DISTAL,
	&"RightIndexProximal" : VmcJoint.RIGHT_INDEX_PROXIMAL,
	&"RightIndexIntermediate" : VmcJoint.RIGHT_INDEX_INTERMEDIATE,
	&"RightIndexDistal" : VmcJoint.RIGHT_INDEX_DISTAL,
	&"RightMiddleProximal" : VmcJoint.RIGHT_MIDDLE_PROXIMAL,
	&"RightMiddleIntermediate" : VmcJoint.RIGHT_MIDDLE_INTERMEDIATE,
	&"RightMiddleDistal" : VmcJoint.RIGHT_MIDDLE_DISTAL,
	&"RightRingProximal" : VmcJoint.RIGHT_RING_PROXIMAL,
	&"RightRingIntermediate" : VmcJoint.RIGHT_RING_INTERMEDIATE,
	&"RightRingDistal" : VmcJoint.RIGHT_RING_DISTAL,
	&"RightLittleProximal" : VmcJoint.RIGHT_LITTLE_PROXIMAL,
	&"RightLittleIntermediate" : VmcJoint.RIGHT_LITTLE_INTERMEDIATE,
	&"RightLittleDistal" : VmcJoint.RIGHT_LITTLE_DISTAL
}

## Dictionary of VMC Face Blend names to face blends
const VmcFaceBlendNames := {
	&"EyeLookUpLeft" : VmcFaceBlend.EYE_LOOK_UP_LEFT,
	&"EyeLookUpRight" : VmcFaceBlend.EYE_LOOK_UP_RIGHT,
	&"EyeLookDownLeft" : VmcFaceBlend.EYE_LOOK_DOWN_LEFT,
	&"EyeLookDownRight" : VmcFaceBlend.EYE_LOOK_DOWN_RIGHT,
	&"EyeLookInLeft" : VmcFaceBlend.EYE_LOOK_IN_LEFT,
	&"EyeLookInRight" : VmcFaceBlend.EYE_LOOK_IN_RIGHT,
	&"EyeLookOutLeft" : VmcFaceBlend.EYE_LOOK_OUT_LEFT,
	&"EyeLookOutRight" : VmcFaceBlend.EYE_LOOK_OUT_RIGHT,
	&"EyeBlinkLeft" : VmcFaceBlend.EYE_BLINK_LEFT,
	&"EyeBlinkRight" : VmcFaceBlend.EYE_BLINK_RIGHT,
	&"EyeSquintLeft" : VmcFaceBlend.EYE_SQUINT_LEFT,
	&"EyeSquintRight" : VmcFaceBlend.EYE_SQUINT_RIGHT,
	&"EyeWideLeft" : VmcFaceBlend.EYE_WIDE_LEFT,
	&"EyeWideRight" : VmcFaceBlend.EYE_WIDE_RIGHT,
	&"BrowDownLeft" : VmcFaceBlend.BROW_DOWN_LEFT,
	&"BrowDownRight" : VmcFaceBlend.BROW_DOWN_RIGHT,
	&"BrowInnerUp" : VmcFaceBlend.BROW_INNER_UP,
	&"BrowOuterUpLeft" : VmcFaceBlend.BROW_OUTER_UP_LEFT,
	&"BrowOuterUpRight" : VmcFaceBlend.BROW_OUTER_UP_RIGHT,
	&"NoseSneerLeft" : VmcFaceBlend.NOSE_SNEER_LEFT,
	&"NoseSneerRight" : VmcFaceBlend.NOSE_SNEER_RIGHT,
	&"CheekSquintLeft" : VmcFaceBlend.CHEEK_SQUINT_LEFT,
	&"CheekSquintRight" : VmcFaceBlend.CHEEK_SQUINT_RIGHT,
	&"CheekPuff" : VmcFaceBlend.CHEEK_PUFF,
	&"JawOpen" : VmcFaceBlend.JAW_OPEN,
	&"MouthClose" : VmcFaceBlend.MOUTH_CLOSE,
	&"JawRight" : VmcFaceBlend.JAW_RIGHT,
	&"JawLeft" : VmcFaceBlend.JAW_LEFT,
	&"JawForward" : VmcFaceBlend.JAW_FORWARD,
	&"MouthRollUpper" : VmcFaceBlend.MOUTH_ROLL_UPPER,
	&"MouthRollLower" : VmcFaceBlend.MOUTH_ROLL_LOWER,
	&"MouthFunnel" : VmcFaceBlend.MOUTH_FUNNEL,
	&"MouthPucker" : VmcFaceBlend.MOUTH_PUCKER,
	&"MouthUpperUpLeft" : VmcFaceBlend.MOUTH_UPPER_UP_LEFT,
	&"MouthUpperUpRight" : VmcFaceBlend.MOUTH_UPPER_UP_RIGHT,
	&"MouthLowerDownLeft" : VmcFaceBlend.MOUTH_LOWER_DOWN_LEFT,
	&"MouthLowerDownRight" : VmcFaceBlend.MOUTH_LOWER_DOWN_RIGHT,
	&"MouthSmileLeft" : VmcFaceBlend.MOUTH_SMILE_LEFT,
	&"MouthSmileRight" : VmcFaceBlend.MOUTH_SMILE_RIGHT,
	&"MouthFrownLeft" : VmcFaceBlend.MOUTH_FROWN_LEFT,
	&"MouthFrownRight" : VmcFaceBlend.MOUTH_FROWN_RIGHT,
	&"MouthStretchLeft" : VmcFaceBlend.MOUTH_STRETCH_LEFT,
	&"MouthStretchRight" : VmcFaceBlend.MOUTH_STRETCH_RIGHT,
	&"MouthDimpleLeft" : VmcFaceBlend.MOUTH_DIMPLE_LEFT,
	&"MouthDimpleRight" : VmcFaceBlend.MOUTH_DIMPLE_RIGHT,
	&"MouthShrugUpper" : VmcFaceBlend.MOUTH_SHRUG_UPPER,
	&"MouthShrugLower" : VmcFaceBlend.MOUTH_SHRUG_LOWER,
	&"MouthPressLeft" : VmcFaceBlend.MOUTH_PRESS_LEFT,
	&"MouthPressRight" : VmcFaceBlend.MOUTH_PRESS_RIGHT,
	&"TongueOut" : VmcFaceBlend.TONGUE_OUT,
}

## VMC Joint Parent relationship
const VmcJointParent : Array[VmcJoint] = [
	-1,									# 0: VmcJoint.HIPS
	VmcJoint.HIPS,						# 1: VmcJoint.SPINE
	VmcJoint.SPINE,						# 2: VmcJoint.CHEST
	VmcJoint.CHEST,						# 3: VmcJoint.UPPER_CHEST
	VmcJoint.UPPER_CHEST,				# 4: VmcJoint.NECK
	VmcJoint.NECK,						# 5: VmcJoint.HEAD
	VmcJoint.HEAD,						# 6: VmcJoint.LEFT_EYE
	VmcJoint.HEAD,						# 7: VmcJoint.RIGHT_EYE
	VmcJoint.HEAD,						# 8: VmcJoint.JAW
	VmcJoint.HIPS,						# 9: VmcJoint.LEFT_UPPER_LEG
	VmcJoint.LEFT_UPPER_LEG,			# 10: VmcJoint.LEFT_LOWER_LEG
	VmcJoint.LEFT_LOWER_LEG,			# 11: VmcJoint.LEFT_FOOT
	VmcJoint.LEFT_FOOT,					# 12: VmcJoint.LEFT_TOES
	VmcJoint.HIPS,						# 13: VmcJoint.RIGHT_UPPER_LEG
	VmcJoint.RIGHT_UPPER_LEG,			# 14: VmcJoint.RIGHT_LOWER_LEG
	VmcJoint.RIGHT_LOWER_LEG,			# 15: VmcJoint.RIGHT_FOOT
	VmcJoint.RIGHT_FOOT,				# 16: VmcJoint.RIGHT_TOES
	VmcJoint.UPPER_CHEST,				# 17: VmcJoint.LEFT_SHOULDER
	VmcJoint.LEFT_SHOULDER,				# 18: VmcJoint.LEFT_UPPER_ARM
	VmcJoint.LEFT_UPPER_ARM,			# 19: VmcJoint.LEFT_LOWER_ARM
	VmcJoint.LEFT_LOWER_ARM,			# 20: VmcJoint.LEFT_HAND
	VmcJoint.UPPER_CHEST,				# 21: VmcJoint.RIGHT_SHOULDER
	VmcJoint.RIGHT_SHOULDER,			# 22: VmcJoint.RIGHT_UPPER_ARM
	VmcJoint.RIGHT_UPPER_ARM,			# 23: VmcJoint.RIGHT_LOWER_ARM
	VmcJoint.RIGHT_LOWER_ARM,			# 24: VmcJoint.RIGHT_HAND
	VmcJoint.LEFT_HAND,					# 25: VmcJoint.LEFT_THUMB_PROXIMAL
	VmcJoint.LEFT_THUMB_PROXIMAL,		# 26: VmcJoint.LEFT_THUMB_INTERMEDIATE
	VmcJoint.LEFT_THUMB_INTERMEDIATE,	# 27: VmcJoint.LEFT_THUMB_DISTAL
	VmcJoint.LEFT_HAND,					# 28: VmcJoint.LEFT_INDEX_PROXIMAL
	VmcJoint.LEFT_INDEX_PROXIMAL,		# 29: VmcJoint.LEFT_INDEX_INTERMEDIATE
	VmcJoint.LEFT_INDEX_INTERMEDIATE,	# 30: VmcJoint.LEFT_INDEX_DISTAL
	VmcJoint.LEFT_HAND,					# 31: VmcJoint.LEFT_MIDDLE_PROXIMAL
	VmcJoint.LEFT_MIDDLE_PROXIMAL,		# 32: VmcJoint.LEFT_MIDDLE_INTERMEDIATE
	VmcJoint.LEFT_MIDDLE_INTERMEDIATE,	# 33: VmcJoint.LEFT_MIDDLE_DISTAL
	VmcJoint.LEFT_HAND,					# 34: VmcJoint.LEFT_RING_PROXIMAL
	VmcJoint.LEFT_RING_PROXIMAL,		# 35: VmcJoint.LEFT_RING_INTERMEDIATE
	VmcJoint.LEFT_RING_INTERMEDIATE,	# 36: VmcJoint.LEFT_RING_DISTAL
	VmcJoint.LEFT_HAND,					# 37: VmcJoint.LEFT_LITTLE_PROXIMAL
	VmcJoint.LEFT_LITTLE_PROXIMAL,		# 38: VmcJoint.LEFT_LITTLE_INTERMEDIATE
	VmcJoint.LEFT_LITTLE_INTERMEDIATE,	# 39: VmcJoint.LEFT_LITTLE_DISTAL
	VmcJoint.RIGHT_HAND,				# 40: VmcJoint.RIGHT_THUMB_PROXIMAL
	VmcJoint.RIGHT_THUMB_PROXIMAL,		# 41: VmcJoint.RIGHT_THUMB_INTERMEDIATE
	VmcJoint.RIGHT_THUMB_INTERMEDIATE,	# 42: VmcJoint.RIGHT_THUMB_DISTAL
	VmcJoint.RIGHT_HAND,				# 43: VmcJoint.RIGHT_INDEX_PROXIMAL
	VmcJoint.RIGHT_INDEX_PROXIMAL,		# 44: VmcJoint.RIGHT_INDEX_INTERMEDIATE
	VmcJoint.RIGHT_INDEX_INTERMEDIATE,	# 45: VmcJoint.RIGHT_INDEX_DISTAL
	VmcJoint.RIGHT_HAND,				# 46: VmcJoint.RIGHT_MIDDLE_PROXIMAL
	VmcJoint.RIGHT_MIDDLE_PROXIMAL,		# 47: VmcJoint.RIGHT_MIDDLE_INTERMEDIATE
	VmcJoint.RIGHT_MIDDLE_INTERMEDIATE,	# 48: VmcJoint.RIGHT_MIDDLE_DISTAL
	VmcJoint.RIGHT_HAND,				# 49: VmcJoint.RIGHT_RING_PROXIMAL
	VmcJoint.RIGHT_RING_PROXIMAL,		# 50: VmcJoint.RIGHT_RING_INTERMEDIATE
	VmcJoint.RIGHT_RING_INTERMEDIATE,	# 51: VmcJoint.RIGHT_RING_DISTAL
	VmcJoint.RIGHT_HAND,				# 52: VmcJoint.RIGHT_LITTLE_PROXIMAL
	VmcJoint.RIGHT_LITTLE_PROXIMAL,		# 53: VmcJoint.RIGHT_LITTLE_INTERMEDIATE
	VmcJoint.RIGHT_LITTLE_INTERMEDIATE,	# 54: VmcJoint.RIGHT_LITTLE_DISTAL
]

## Mapping of XRBodyTracker joints to VMC joints
const VmcJointMapping : Array[Dictionary] = [
	# Upper Body Joints
	{
		body = XRBodyTracker.JOINT_HIPS,
		vmc = VmcJoint.HIPS,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_SPINE,
		vmc = VmcJoint.SPINE,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_CHEST,
		vmc = VmcJoint.CHEST,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_UPPER_CHEST,
		vmc = VmcJoint.UPPER_CHEST,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_NECK,
		vmc = VmcJoint.NECK,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_HEAD,
		vmc = VmcJoint.HEAD,
		roll = Quaternion(0.0, 1.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_SHOULDER,
		vmc = VmcJoint.LEFT_SHOULDER,
		roll = Quaternion(-0.5, 0.5, 0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_UPPER_ARM,
		vmc = VmcJoint.LEFT_UPPER_ARM,
		roll = Quaternion(0.5, -0.5, 0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_LOWER_ARM,
		vmc = VmcJoint.LEFT_LOWER_ARM,
		roll = Quaternion(-0.7071068, 0.7071068, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_SHOULDER,
		vmc = VmcJoint.RIGHT_SHOULDER,
		roll = Quaternion(0.5, 0.5, 0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_UPPER_ARM,
		vmc = VmcJoint.RIGHT_UPPER_ARM,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_LOWER_ARM,
		vmc = VmcJoint.RIGHT_LOWER_ARM,
		roll = Quaternion(0.7071068, 0.7071068, 0.0, 0.0)
	},

	# Lower Body Joints
	{
		body = XRBodyTracker.JOINT_LEFT_UPPER_LEG,
		vmc = VmcJoint.LEFT_UPPER_LEG,
		roll = Quaternion(1.0, 0.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_LOWER_LEG,
		vmc = VmcJoint.LEFT_LOWER_LEG,
		roll = Quaternion(0.0, 0.0, 1.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_FOOT,
		vmc = VmcJoint.LEFT_FOOT,
		roll = Quaternion(-0.7071068, 0.0, 0.0, 0.7071068)
	},
	#{
	#	body = XRBodyTracker.JOINT_LEFT_TOES,
	#	vmc = VmcJoint.LEFT_TOES,
	#	roll = Quaternion(-0.7071068, 0.0, 0.0, 0.7071068)
	#},
	{
		body = XRBodyTracker.JOINT_RIGHT_UPPER_LEG,
		vmc = VmcJoint.RIGHT_UPPER_LEG,
		roll = Quaternion(1.0, 0.0, 0.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_LOWER_LEG,
		vmc = VmcJoint.RIGHT_LOWER_LEG,
		roll = Quaternion(0.0, 0.0, 1.0, 0.0)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_FOOT,
		vmc = VmcJoint.RIGHT_FOOT,
		roll = Quaternion(-0.7071068, 0.0, 0.0, 0.7071068)
	},
	#{
	#	body = XRBodyTracker.JOINT_RIGHT_TOES,
	#	vmc = VmcJoint.RIGHT_TOES,
	#	roll = Quaternion(-0.7071068, 0.0, 0.0, 0.7071068)
	#},

	# Left Hand Joints
	{
		body = XRBodyTracker.JOINT_LEFT_HAND,
		vmc = VmcJoint.LEFT_HAND,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_WRIST,
		vmc = VmcJoint.LEFT_HAND,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_THUMB_METACARPAL,
		vmc = VmcJoint.LEFT_THUMB_PROXIMAL,
		roll = Quaternion(0.3535534, -0.6123724, 0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_THUMB_PHALANX_PROXIMAL,
		vmc = VmcJoint.LEFT_THUMB_INTERMEDIATE,
		roll = Quaternion(0.3535534, -0.6123724, 0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_THUMB_PHALANX_DISTAL,
		vmc = VmcJoint.LEFT_THUMB_DISTAL,
		roll = Quaternion(0.3535534, -0.6123724, 0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_INDEX_FINGER_PHALANX_PROXIMAL,
		vmc = VmcJoint.LEFT_INDEX_PROXIMAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_INDEX_FINGER_PHALANX_INTERMEDIATE,
		vmc = VmcJoint.LEFT_INDEX_INTERMEDIATE,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_INDEX_FINGER_PHALANX_DISTAL,
		vmc = VmcJoint.LEFT_INDEX_DISTAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_MIDDLE_FINGER_PHALANX_PROXIMAL,
		vmc = VmcJoint.LEFT_MIDDLE_PROXIMAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_MIDDLE_FINGER_PHALANX_INTERMEDIATE,
		vmc = VmcJoint.LEFT_MIDDLE_INTERMEDIATE,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_MIDDLE_FINGER_PHALANX_DISTAL,
		vmc = VmcJoint.LEFT_MIDDLE_DISTAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_RING_FINGER_PHALANX_PROXIMAL,
		vmc = VmcJoint.LEFT_RING_PROXIMAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_RING_FINGER_PHALANX_INTERMEDIATE,
		vmc = VmcJoint.LEFT_RING_INTERMEDIATE,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_RING_FINGER_PHALANX_DISTAL,
		vmc = VmcJoint.LEFT_RING_DISTAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_PINKY_FINGER_PHALANX_PROXIMAL,
		vmc = VmcJoint.LEFT_LITTLE_PROXIMAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_PINKY_FINGER_PHALANX_INTERMEDIATE,
		vmc = VmcJoint.LEFT_LITTLE_INTERMEDIATE,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},
	{
		body = XRBodyTracker.JOINT_LEFT_PINKY_FINGER_PHALANX_DISTAL,
		vmc = VmcJoint.LEFT_LITTLE_DISTAL,
		roll = Quaternion(-0.5, 0.5, -0.5, -0.5)
	},

	# Right Hand Joints
	{
		body = XRBodyTracker.JOINT_RIGHT_HAND,
		vmc = VmcJoint.RIGHT_HAND,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_WRIST,
		vmc = VmcJoint.RIGHT_HAND,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_THUMB_METACARPAL,
		vmc = VmcJoint.RIGHT_THUMB_PROXIMAL,
		roll = Quaternion(0.3535534, 0.6123724, -0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_THUMB_PHALANX_PROXIMAL,
		vmc = VmcJoint.RIGHT_THUMB_INTERMEDIATE,
		roll = Quaternion(0.3535534, 0.6123724, -0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_THUMB_PHALANX_DISTAL,
		vmc = VmcJoint.RIGHT_THUMB_DISTAL,
		roll = Quaternion(0.3535534, 0.6123724, -0.6123724, 0.3535534)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_INDEX_FINGER_PHALANX_PROXIMAL,
		vmc = VmcJoint.RIGHT_INDEX_PROXIMAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_INDEX_FINGER_PHALANX_INTERMEDIATE,
		vmc = VmcJoint.RIGHT_INDEX_INTERMEDIATE,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_INDEX_FINGER_PHALANX_DISTAL,
		vmc = VmcJoint.RIGHT_INDEX_DISTAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_MIDDLE_FINGER_PHALANX_PROXIMAL,
		vmc = VmcJoint.RIGHT_MIDDLE_PROXIMAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_MIDDLE_FINGER_PHALANX_INTERMEDIATE,
		vmc = VmcJoint.RIGHT_MIDDLE_INTERMEDIATE,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_MIDDLE_FINGER_PHALANX_DISTAL,
		vmc = VmcJoint.RIGHT_MIDDLE_DISTAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_RING_FINGER_PHALANX_PROXIMAL,
		vmc = VmcJoint.RIGHT_RING_PROXIMAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_RING_FINGER_PHALANX_INTERMEDIATE,
		vmc = VmcJoint.RIGHT_RING_INTERMEDIATE,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_RING_FINGER_PHALANX_DISTAL,
		vmc = VmcJoint.RIGHT_RING_DISTAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_PINKY_FINGER_PHALANX_PROXIMAL,
		vmc = VmcJoint.RIGHT_LITTLE_PROXIMAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_PINKY_FINGER_PHALANX_INTERMEDIATE,
		vmc = VmcJoint.RIGHT_LITTLE_INTERMEDIATE,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
	{
		body = XRBodyTracker.JOINT_RIGHT_PINKY_FINGER_PHALANX_DISTAL,
		vmc = VmcJoint.RIGHT_LITTLE_DISTAL,
		roll = Quaternion(0.5, 0.5, -0.5, 0.5)
	},
]

## Mapping of XRFaceTracker blends to VMC face blends
const VmcFaceBlendMapping : Array[Dictionary] = [
	# Upper Body Joints
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_OUT_RIGHT ],
		vmc = [ VmcFaceBlend.EYE_LOOK_OUT_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_IN_RIGHT ],
		vmc = [ VmcFaceBlend.EYE_LOOK_IN_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_UP_RIGHT ],
		vmc = [ VmcFaceBlend.EYE_LOOK_UP_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_DOWN_RIGHT ],
		vmc = [ VmcFaceBlend.EYE_LOOK_DOWN_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_OUT_LEFT ],
		vmc = [ VmcFaceBlend.EYE_LOOK_OUT_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_IN_LEFT ],
		vmc = [ VmcFaceBlend.EYE_LOOK_IN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_UP_LEFT ],
		vmc = [ VmcFaceBlend.EYE_LOOK_UP_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_LOOK_DOWN_LEFT ],
		vmc = [ VmcFaceBlend.EYE_LOOK_DOWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_CLOSED_RIGHT ],
		vmc = [ VmcFaceBlend.EYE_BLINK_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_CLOSED_LEFT ],
		vmc = [ VmcFaceBlend.EYE_BLINK_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_CLOSED ],
		vmc = [ VmcFaceBlend.EYE_BLINK_RIGHT,
				VmcFaceBlend.EYE_BLINK_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_SQUINT_RIGHT ],
		vmc = [ VmcFaceBlend.EYE_SQUINT_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_SQUINT_LEFT ],
		vmc = [ VmcFaceBlend.EYE_SQUINT_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_SQUINT ],
		vmc = [ VmcFaceBlend.EYE_SQUINT_RIGHT,
				VmcFaceBlend.EYE_SQUINT_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_WIDE_RIGHT ],
		vmc = [ VmcFaceBlend.EYE_WIDE_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_WIDE_LEFT ],
		vmc = [ VmcFaceBlend.EYE_WIDE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_EYE_WIDE ],
		vmc = [ VmcFaceBlend.EYE_WIDE_RIGHT,
				VmcFaceBlend.EYE_WIDE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_BROW_DOWN_RIGHT ],
		vmc = [ VmcFaceBlend.BROW_DOWN_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_BROW_DOWN_LEFT ],
		vmc = [ VmcFaceBlend.BROW_DOWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_BROW_DOWN ],
		vmc = [ VmcFaceBlend.BROW_DOWN_RIGHT,
				VmcFaceBlend.BROW_DOWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_BROW_OUTER_UP_RIGHT ],
		vmc = [ VmcFaceBlend.BROW_OUTER_UP_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_BROW_OUTER_UP_LEFT ],
		vmc = [ VmcFaceBlend.BROW_OUTER_UP_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_NOSE_SNEER_RIGHT ],
		vmc = [ VmcFaceBlend.NOSE_SNEER_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_NOSE_SNEER_LEFT ],
		vmc = [ VmcFaceBlend.NOSE_SNEER_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_NOSE_SNEER ],
		vmc = [ VmcFaceBlend.NOSE_SNEER_RIGHT,
				VmcFaceBlend.NOSE_SNEER_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_CHEEK_SQUINT_RIGHT ],
		vmc = [ VmcFaceBlend.CHEEK_SQUINT_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_CHEEK_SQUINT_LEFT ],
		vmc = [ VmcFaceBlend.CHEEK_SQUINT_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_CHEEK_SQUINT ],
		vmc = [ VmcFaceBlend.CHEEK_SQUINT_RIGHT,
				VmcFaceBlend.CHEEK_SQUINT_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_CHEEK_PUFF,
				 XRFaceTracker.FT_CHEEK_PUFF_RIGHT,
				 XRFaceTracker.FT_CHEEK_PUFF_LEFT ],
		vmc = [ VmcFaceBlend.CHEEK_PUFF ],
	},
	{
		face = [ XRFaceTracker.FT_JAW_OPEN ],
		vmc = [ VmcFaceBlend.JAW_OPEN ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_CLOSED ],
		vmc = [ VmcFaceBlend.MOUTH_CLOSE ],
	},
	{
		face = [ XRFaceTracker.FT_JAW_RIGHT ],
		vmc = [ VmcFaceBlend.JAW_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_JAW_LEFT ],
		vmc = [ VmcFaceBlend.JAW_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_JAW_FORWARD ],
		vmc = [ VmcFaceBlend.JAW_FORWARD ],
	},
	{
		face = [ XRFaceTracker.FT_LIP_FUNNEL,
				 XRFaceTracker.FT_LIP_FUNNEL_UPPER,
				 XRFaceTracker.FT_LIP_FUNNEL_LOWER ],
		vmc = [ VmcFaceBlend.MOUTH_FUNNEL ],
	},
	{
		face = [ XRFaceTracker.FT_LIP_PUCKER,
				 XRFaceTracker.FT_LIP_PUCKER_UPPER,
				 XRFaceTracker.FT_LIP_PUCKER_LOWER ],
		vmc = [ VmcFaceBlend.MOUTH_PUCKER ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_UPPER_UP_RIGHT ],
		vmc = [ VmcFaceBlend.MOUTH_UPPER_UP_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_UPPER_UP_LEFT ],
		vmc = [ VmcFaceBlend.MOUTH_UPPER_UP_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_UPPER_UP ],
		vmc = [ VmcFaceBlend.MOUTH_UPPER_UP_RIGHT,
				VmcFaceBlend.MOUTH_UPPER_UP_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_LOWER_DOWN_RIGHT ],
		vmc = [ VmcFaceBlend.MOUTH_LOWER_DOWN_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_LOWER_DOWN_LEFT ],
		vmc = [ VmcFaceBlend.MOUTH_LOWER_DOWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_LOWER_DOWN ],
		vmc = [ VmcFaceBlend.MOUTH_LOWER_DOWN_RIGHT,
				VmcFaceBlend.MOUTH_LOWER_DOWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_SMILE_RIGHT ],
		vmc = [ VmcFaceBlend.MOUTH_SMILE_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_SMILE_LEFT ],
		vmc = [ VmcFaceBlend.MOUTH_SMILE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_SMILE ],
		vmc = [ VmcFaceBlend.MOUTH_SMILE_RIGHT,
				VmcFaceBlend.MOUTH_SMILE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_FROWN_RIGHT ],
		vmc = [ VmcFaceBlend.MOUTH_FROWN_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_FROWN_LEFT ],
		vmc = [ VmcFaceBlend.MOUTH_FROWN_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_STRETCH_RIGHT ],
		vmc = [ VmcFaceBlend.MOUTH_STRETCH_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_STRETCH_LEFT ],
		vmc = [ VmcFaceBlend.MOUTH_STRETCH_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_STRETCH ],
		vmc = [ VmcFaceBlend.MOUTH_STRETCH_RIGHT,
				VmcFaceBlend.MOUTH_STRETCH_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_DIMPLE_RIGHT ],
		vmc = [ VmcFaceBlend.MOUTH_DIMPLE_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_DIMPLE_LEFT ],
		vmc = [ VmcFaceBlend.MOUTH_DIMPLE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_DIMPLE ],
		vmc = [ VmcFaceBlend.MOUTH_DIMPLE_RIGHT,
				VmcFaceBlend.MOUTH_DIMPLE_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_PRESS_RIGHT ],
		vmc = [ VmcFaceBlend.MOUTH_PRESS_RIGHT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_PRESS_LEFT ],
		vmc = [ VmcFaceBlend.MOUTH_PRESS_LEFT ],
	},
	{
		face = [ XRFaceTracker.FT_MOUTH_PRESS ],
		vmc = [ VmcFaceBlend.MOUTH_PRESS_RIGHT,
				VmcFaceBlend.MOUTH_PRESS_LEFT ],
	},
]


# OSC reader instance
var _osc_reader : OSCReader = OSCReader.new()

# Face tracker instance
var _face_tracker : XRFaceTracker = XRFaceTracker.new()

# Body tracker instance
var _body_tracker : XRBodyTracker = XRBodyTracker.new()

# Array of VMC relative positions
var _vmc_rel_positions : Array[Vector3] = []

# Array of VMC relative rotations
var _vmc_rel_rotations : Array[Quaternion] = []

# Array of VMC absolute positions
var _vmc_abs_positions : Array[Vector3] = []

# Array of VMC absolute rotations
var _vmc_abs_rotations : Array[Quaternion] = []

# Array of VMC face blends
var _vmc_face_blends : Array[float] = []

# True if new joint data available
var _new_joints : bool = false

# True if new face blend data available
var _new_face_blends : bool = false


func _enter_tree() -> void:
	# Fill the position and rotation arrays
	_vmc_rel_positions.resize(VmcJoint.COUNT)
	_vmc_rel_rotations.resize(VmcJoint.COUNT)
	_vmc_abs_positions.resize(VmcJoint.COUNT)
	_vmc_abs_rotations.resize(VmcJoint.COUNT)
	_vmc_rel_positions.fill(Vector3.ZERO)
	_vmc_rel_rotations.fill(Quaternion.IDENTITY)
	_vmc_abs_positions.fill(Vector3.ZERO)
	_vmc_abs_rotations.fill(Quaternion.IDENTITY)

	# Fill the face blend array
	_vmc_face_blends.resize(VmcFaceBlend.COUNT)
	_vmc_face_blends.fill(0.0)

	# Get the face tracker name
	var face_tracker_name : String = ProjectSettings.get_setting(
		"godot_vmc_tracker/trackers/face_tracker",
		"/vmc/head")

	# Register the face tracker
	XRServer.add_face_tracker(face_tracker_name, _face_tracker)

	# Get the body tracker name
	var body_tracker_name : String = ProjectSettings.get_setting(
		"godot_vmc_tracker/trackers/body_tracker",
		"/vmc/body")

	# Register the body tracker
	XRServer.add_body_tracker(body_tracker_name, _body_tracker)

	# Get the VMC port number
	var port : int = ProjectSettings.get_setting(
		"godot_vmc_tracker/network/port",
		39539)

	# Start listening for VMC packets
	_osc_reader.on_osc_packet.connect(_on_osc_packet)
	_osc_reader.listen(port)


func _process(_delta : float) -> void:
	# Poll for incoming packets
	_osc_reader.poll()


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


func _on_vmc_ext_bone_pos(entry : Array) -> void:
	# Get the VMC joint
	var joint : VmcJoint = VmcJointNames.get(entry[1], -1)
	if joint < 0:
		return

	# Save the relative positions and rotations
	_vmc_rel_positions[joint] = Vector3(entry[2], entry[3], -entry[4])
	_vmc_rel_rotations[joint] = Quaternion(entry[5], entry[6], -entry[7], -entry[8])
	_new_joints = true


func _on_vmc_ext_blend_val(entry : Array) -> void:
	# Get the VMC face blend
	var blend : VmcFaceBlend = VmcFaceBlendNames.get(entry[1], -1)
	if blend < 0:
		return

	# Save the face blend
	_vmc_face_blends[blend] = entry[2]
	_new_face_blends = true
	pass


func _process_joints() -> void:
	# Iterate over the joints
	for joint in VmcJoint.COUNT:
		# Get the joint information and relative location
		var parent_joint := VmcJointParent[joint]
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
	for joint in VmcJointMapping:
		var body : XRBodyTracker.Joint = joint["body"]
		var vmc : VmcJoint = joint["vmc"]
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


func _process_face_blends() -> void:
	# Apply to the XRFaceTracker
	for blend in VmcFaceBlendMapping:
		var face : Array = blend["face"]
		var vmc : Array = blend["vmc"]

		var weight := 0.0
		for v in vmc:
			weight += _vmc_face_blends[v]
		weight /= vmc.size()

		# Set the face blend weight
		for f in face:
			_face_tracker.set_blend_shape(f, weight)
