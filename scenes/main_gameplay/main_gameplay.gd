extends Node2D

@export var stage: Stage

@onready var camera_shake: CameraShake = $Camera2D/CameraShake
@onready var resume_game_button: Button = %ResumeGameButton
@onready var how_to_play_button: Button = %HowToPlayButton
@onready var options_button: Button = %OptionsButton
var stage_phase: int = -1

var current_stage_phase: Node

func _ready() -> void:
	# time for tight coupling boyz
	$Player.summoning_circle_ref = $SummoningCircle
	$SummoningCircle.player_ref = $Player
	
	if stage:
		next_stage_phase()


func next_stage_phase() -> void:
	if current_stage_phase:
		current_stage_phase.queue_free()
		current_stage_phase = null
	stage_phase += 1
	if stage_phase < stage.phases.size():
		current_stage_phase = stage.phases[stage_phase].instantiate()
		current_stage_phase.phase_complete.connect(_on_phase_complete)
		add_child(current_stage_phase)
	if stage_phase == stage.phases.size() - 1:
		%HealthBar.visible = true
	else:
		%HealthBar.visible = false
		print_rich("[rainbow][tornado]STAGE DONE!!!![/tornado][/rainbow]")

func _on_phase_complete() -> void:
	next_stage_phase()

func _on_bouncing_character_body_2d_bounce(collision: KinematicCollision2D) -> void:
	#camera_shake.apply_impulse(Vector2.from_angle(randf_range(0, TAU)) * 2000)
	camera_shake.rumble(50, 0.25)


func _on_player_player_died() -> void:
	SceneGirl.change_scene("res://scenes/game_over/game_over.tscn")


func _on_resume_game_button_pressed() -> void:
	$Player._un_pause()


func _on_main_menu_button_pressed() -> void:
	
	SceneGirl.change_scene("res://scenes/main_menu/main_menu.tscn")


func _on_resume_game_button_mouse_entered() -> void:
	resume_game_button.grab_focus()
