extends Node2D

var stage: Stage

@onready var camera_shake: CameraShake = $Camera2D/CameraShake
var stage_phase: int = -1

var current_stage_phase: Node


func _ready() -> void:
	stage = Globals.main_gameplay_stage
	assert(stage != null)
	
	# time for tight coupling boyz
	$Player.summoning_circle_ref = $SummoningCircle
	$SummoningCircle.player_ref = $Player
	$SummoningCircle.camera_shake_ref = camera_shake
	
	if stage:
		next_stage_phase.call_deferred()


func next_stage_phase() -> void:
	if current_stage_phase:
		current_stage_phase.queue_free()
		current_stage_phase = null
	stage_phase += 1
	if stage_phase < stage.phases.size():
		current_stage_phase = stage.phases[stage_phase].stage_phase.instantiate()
		if "enemy_resource" in current_stage_phase:
			current_stage_phase.enemy_resource = stage.phases[stage_phase].enemy_resource
		current_stage_phase.phase_complete.connect(_on_phase_complete)
		add_child(current_stage_phase)
		if stage_phase == stage.phases.size() - 1:
			%HealthBar.visible = true
	else:
		stage_complete()

func _on_phase_complete() -> void:
	next_stage_phase()

func _on_bouncing_character_body_2d_bounce(collision: KinematicCollision2D) -> void:
	#camera_shake.apply_impulse(Vector2.from_angle(randf_range(0, TAU)) * 2000)
	camera_shake.rumble(50, 0.25)

func _on_player_player_died() -> void:
	SceneGirl.change_scene("res://scenes/game_over/game_over.tscn")

func stage_complete():
	%HealthBar.visible = false
	print_rich("[rainbow][tornado]STAGE DONE!!!![/tornado][/rainbow]")
	print(stage.stage_name)
	if stage.stage_name == "Oak Hill II" && !Save.current.levels_beaten.has("0"):
		Save.current.levels_beaten.append("0")
		Save.save()
	for bullet in get_tree().get_nodes_in_group("Bullet"):
		bullet.queue_free()
	SceneGirl.change_scene("res://scenes/win/win.tscn")


