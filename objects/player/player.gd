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
@onready var outline = $Outline

const brush_circle_radius = 25

const NORMAL_SPEED = 300.0
const FOCUS_SPEED = 150.0
var current_speed = NORMAL_SPEED

var summoning_circle_ref: Node2D
var summoning = false

var current_element = Globals.Elements.UNSET

@export var current_bullet_resource: BulletResource = preload("res://objects/bullet/resources/player_basic_shot.tres")

var invuln_frame_time = 80

var f = false

func _ready() -> void:
	#Globals.player_health = starting_health
	Globals.player_health_changed.connect(_on_player_health_changed)


func _physics_process(delta: float) -> void:
	if Globals.player_health <= 0:
		return
	if Globals.cheat_timeout > 0:
		Globals.cheat_timeout -= 1
		 
	if Globals.player_invuln > 0:
		Globals.player_invuln -= 1
		
		outline.visible = int(Globals.player_invuln / 5) % 2 == 0
	
	if Input.is_action_pressed("Menu"):
		_pause()
	
	f = not f
	if f and Input.is_action_pressed("Shoot"):
		shoot_bullet()
	
	if Globals.haxor ==1 and Input.is_action_pressed("sigil_1") and  Globals.cheat_timeout ==0:
			summoning_circle_ref.star_sigil()
			Globals.cheat_timeout = 50
	if Globals.haxor ==1 and Input.is_action_pressed("sigil_2") and  Globals.cheat_timeout ==0:
			summoning_circle_ref.circle_sigil()
			Globals.cheat_timeout = 50
	if Globals.haxor ==1 and Input.is_action_pressed("sigil_3") and  Globals.cheat_timeout ==0:
			summoning_circle_ref.s_sigil()
			Globals.cheat_timeout = 50
	if Globals.haxor ==1 and Input.is_action_pressed("sigil_4") and  Globals.cheat_timeout ==0:
			summoning_circle_ref.w_sigil()
			Globals.cheat_timeout = 50
	if Globals.haxor ==1 and Input.is_action_pressed("sigil_5") and  Globals.cheat_timeout ==0:
			summoning_circle_ref.spiral_sigil()
			Globals.cheat_timeout = 50
	if Globals.haxor ==1 and Input.is_action_pressed("invuln_mode") and  Globals.cheat_timeout ==0:
			Globals.player_invuln = 100000
	
	if Input.is_action_pressed("Summon"):
		current_speed = FOCUS_SPEED
		$Hitbox.frame = 1
		if !summoning:
			summoning_circle_ref.player_started_summoning()
			summoning = true
		summon_tick()
	else:
		current_speed = NORMAL_SPEED
		$Hitbox.frame = 0
		summoning = false
		if summoning_circle_ref.current_sigil_sequence.size() < 5:
			summoning_circle_ref.reset_summoning_circle()

	var direction := Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down"))
	velocity = direction * current_speed

	move_and_slide()
	
	set_element_outline()
	
	# regenerate ink
	if Globals.summon_ink < 100 and summoning == false:
		Globals.summon_ink += 0.50

func set_element_outline():
	if current_element == Globals.Elements.FIRE:
		outline.material.set("shader_parameter/fillColor", Vector4(1, 0, 0, 1))
	if current_element == Globals.Elements.WATER:
		outline.material.set("shader_parameter/fillColor", Vector4(0, 0, 1, 1))
	if current_element == Globals.Elements.VEGANS:
		outline.material.set("shader_parameter/fillColor", Vector4(0, 1, 0, 1))
	#if element == Globals.Elements.AIR:
		#outline.material.set("shader_parameter/fillColor", Vector4(1, 1, 0, 1))
	#if element == Globals.Elements.DARK:
		#outline.material.set("shader_parameter/fillColor", Vector4(0.5, 0, 1, 1))
	if current_element == Globals.Elements.UNSET:
		outline.material.set("shader_parameter/fillColor", Vector4(0, 0, 0, 0))

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
		MusicMan.sfx(preload("res://sfx/player_shoot_2.wav"), "is_credit_to_team", 1, true)
		refire_delay_timer.start()

func _on_player_health_changed() -> void:
	if Globals.player_health <= 0 && $DeathTimer.is_stopped():
		#TODO death SFX
		$DeathTimer.start()
		$DeathParticles.emitting = true
		MusicMan.sfx(preload("res://sfx/creed.ogg"))
	else:
		Globals.player_invuln = invuln_frame_time
		MusicMan.sfx(preload("res://sfx/player_hit.wav"))


func _on_death_timer_timeout() -> void:
	$DeathParticles.emitting = false
	player_died.emit()

func _pause()->void:
	get_tree().paused = true
	get_tree().root.add_child(pause_scene.instantiate())

