extends Node2D

@onready var camera_shake: CameraShake = $Camera2D/CameraShake

func _ready() -> void:
	# time for tight coupling boyz
	$Player.summoning_circle_ref = $SummoningCircle
	$SummoningCircle.player_ref = $Player

func _on_bouncing_character_body_2d_bounce(collision: KinematicCollision2D) -> void:
	#camera_shake.apply_impulse(Vector2.from_angle(randf_range(0, TAU)) * 2000)
	camera_shake.rumble(50, 0.25)



func _on_example_phase_phase_complete() -> void:
	add_child(preload("res://scenes/main_gameplay/stage_phases/phase_2.tscn").instantiate())


func _on_player_player_died() -> void:
	SceneGirl.change_scene("res://scenes/game_over/game_over.tscn")
