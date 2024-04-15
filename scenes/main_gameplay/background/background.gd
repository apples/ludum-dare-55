extends Node3D


@onready var camera_3d: Camera3D = $CameraRoot/Camera3D

var time: float = 0.0

func _process(delta: float) -> void:
	time += delta
	camera_3d.position.x = 1.0 * sin(time / 10.0)
	camera_3d.position.z = 0.6 * sin(time / 20.0)
	camera_3d.rotation.z = PI / 16.0 * sin(time / 25.0)

