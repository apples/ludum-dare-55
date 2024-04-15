class_name Player
extends CharacterBody2D


signal player_died

@export var starting_health: int = 5

var bullet_scene = preload("res://objects/bullet/bullet.tscn")
var homing_bullet_scene = preload("res://objects/homing_bullet/homing_bullet.tscn")
var bomb_bullet_scene = preload("res://objects/bomb_bullet/bomb_bullet.tscn")
var jericho_bullet_scene = preload("res://objects/jericho_bullet/jericho_bullet.tscn")
var summoning_dust = preload("res://objects/summoning_dust/summoning_dust.tscn")
var pause_scene = preload("res://scenes/pause_menu/pause_menu.tscn") 

@onready var brush_pos = self.global_position #Vector2(0, 0)
@onready var refire_delay_timer = $RefireDelay
const brush_circle_radius = 25

const NORMAL_SPEED = 300.0
const FOCUS_SPEED = 150.0
var current_speed = NORMAL_SPEED

var summoning_circle_ref: Node2D
var summoning = false

var current_element = Globals.Elements.UNSET

@export var current_bullet_resource: BulletResource = preload("res://objects/bullet/resources/fire_bomb.tres")

var invuln_frame_time = 80

func _ready() -> void:
	Globals.player_health = starting_health
	Globals.player_health_changed.connect(_on_player_health_changed)


func _physics_process(delta: float) -> void:
	if Globals.player_health <= 0:
		return
	
	if Globals.player_invuln > 0:
		Globals.player_invuln -= 1
	
	if Input.is_action_pressed("Menu"):
		_pause()
		
	if Input.is_action_pressed("Shoot"):
		shoot_bullet()
	
	if Input.is_action_pressed("Summon"):
		current_speed = FOCUS_SPEED
		if !summoning:
			summoning_circle_ref.player_started_summoning()
			summoning = true
		summon_tick()
	else:
		current_speed = NORMAL_SPEED
		summoning = false
		if summoning_circle_ref.current_sigil_sequence.size() < 5:
			summoning_circle_ref.reset_summoning_circle()

	var direction := Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down"))
	velocity = direction * current_speed

	move_and_slide()
	
	# regenerate ink
	if Globals.summon_ink < 100 and summoning == false:
		Globals.summon_ink += 0.50

# Called when colliding with something for any reason.
func _collision(other: PhysicsBody2D) -> void:
	pass


func summon_tick():
	var player_brush_pos_diff = global_position.distance_to(brush_pos)
	if player_brush_pos_diff < brush_circle_radius:
		return
	else:
		if Globals.summon_ink > 0:
			if velocity != Vector2(0,0):
				var v = global_position - brush_pos
				brush_pos += v.normalized() * (player_brush_pos_diff - brush_circle_radius)
				var new_summoning_dust = summoning_dust.instantiate()
				var summoning_dust_pos = brush_pos
				new_summoning_dust.set_position(summoning_dust_pos)
				self.get_parent().add_child(new_summoning_dust)
				#if summoning_circle_ref.sigil_sequence_active:
				Globals.summon_ink -= 0.60
		else:
			if summoning_circle_ref.current_sigil_sequence.size() < 5:
				summoning_circle_ref.reset_summoning_circle()

func shoot_bullet():
	if refire_delay_timer.is_stopped():
		current_bullet_resource.shoot(self,
			$bullet_spawn_location.position,
			$bullet_spawn_location.rotation
		)
		refire_delay_timer.start()

func _on_player_health_changed() -> void:
	if Globals.player_health <= 0 && $DeathTimer.is_stopped():
		#TODO death SFX
		$DeathTimer.start()
		$DeathParticles.emitting = true
	else:
		Globals.player_invuln = invuln_frame_time


func _on_death_timer_timeout() -> void:
	$DeathParticles.emitting = false
	player_died.emit()
func _pause()->void:
	get_tree().paused = true
	get_tree().root.add_child(pause_scene.instantiate())
	
