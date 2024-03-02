# Godot XR VMC Tracker

![GitHub forks](https://img.shields.io/github/forks/Malcolmnixon/GodotXRVmcTracker?style=plastic)
![GitHub Repo stars](https://img.shields.io/github/stars/Malcolmnixon/GodotXRVmcTracker?style=plastic)
![GitHub contributors](https://img.shields.io/github/contributors/Malcolmnixon/GodotXRVmcTracker?style=plastic)
![GitHub](https://img.shields.io/github/license/Malcolmnixon/GodotXRVmcTracker?style=plastic)

This repository contains a VMC-protocol decoder for Godot that can drive avatars through the XR Tracker system.

[<img src="docs/Screenshot 2024-03-02 at 09-54-40 Godot VRM Avatars.png">](https://www.youtube.com/watch?v=eE0UGosv7ek "Godot VRM Avatars")

## Versions

Official releases are tagged and can be found [here](https://github.com/Malcolmnixon/GodotXRVmcTracker/releases).

The following branches are in active development:
|  Branch   |  Description                  |  Godot version   |
|-----------|-------------------------------|------------------|
|  master   | Current development branch    |  Godot 4.3-dev4+ |

## Overview

[VMC Protocol](https://protocol.vmc.info/english.html) is a network protocol for Virtual Motion Capture.

![VMC Protocol Logo](/docs/vmpc_logo_128x128.png)

## Usage

The following steps show how to add the Godot VMC tracker to a project.

### Enable Addon

The addon files needs to be copied to the `/addons/godot_vmc_tracker` folder of the Godot project, and then enabled in Plugins under the Project Settings:
![Enable Plugin](/docs/enable_plugin.png)

### Plugin Settings

The plugin has numerous options to control behavior:

![Plugin Options](/docs/plugin_settings.png)

| Option | Description |
| :----- | :---------- |
| Tracking - Position Mode | Controls the position of the character:<br>- Free = Free Movement<br>- Calibrate = Calibrate to origin on first frame<br>- Locked = Lock to origin |
| Tracking - Face Tracker Name | Name for the XRFaceTracker |
| Tracking - Body Tracker Name | Name for the XRBodyTracker |
| Network - Udp Listener Port | Port to listen for VMC network packets |

### Character Importing

The character model must be in Godot Humanoid format. This can be achieved in the importer settings by retarteting the skeleton to the SkeletonProfileHumanoid bone map:

![Character Import](/docs/character_import.png)

### Body Driving

The body is driven using an [XRBodyModifier3D](https://docs.godotengine.org/en/latest/classes/class_xrbodymodifier3d.html) node configured to drive the skeleton of the character:

![XRBodyModifier3D](/docs/xrbodymodifier3d.png)

Note that the Body Tracker name should match the Body Tracker Name specified in the Plugin Settings.

### Face Driving

The face is driven using an [XRFaceModifier3D](https://docs.godotengine.org/en/latest/classes/class_xrfacemodifier3d.html) node configured to drive the facial blendshapes of the character:

![XRFaceModifier3D](/docs/xrfacemodifier3d.png)

Note that the Face Tracker name should match the Face Tracker Name specified in the Plugin Settings.

### VMC Tracking Application

A VMC tracking application must be used to capture the users body and face information and stream it over the VMC protocol. One option that works well is [XR Animator](https://github.com/ButzYung/SystemAnimatorOnline)
when configured with an avatar equipped with the full ARKit 52 blendshapes.

The models in the demo project use the public [Test Chan](https://kanafuyuko.booth.pm/items/5419110) and [Test Kun](https://kanafuyuko.booth.pm/items/5420804) models by Kana Fuyuko

## Licensing

Code in this repository is licensed under the MIT license.

## About this repository

This repository was created by Malcolm Nixon

It is primarily maintained by:
- [Malcolm Nixon](https://github.com/Malcolmnixon/)

For further contributors please see `CONTRIBUTORS.md`
