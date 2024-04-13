extends CharacterBody2D

signal player_died

@export var starting_health: int = 1

var bullet_scene = preload("res://objects/bullet/bullet.tscn")
var summoning_dust = preload("res://objects/summoning_dust/summoning_dust.tscn")

@onready var brush_pos = self.global_position #Vector2(0, 0)
@onready var refire_delay_timer = $RefireDelay
const brush_circle_radius = 25

const NORMAL_SPEED = 300.0
const FOCUS_SPEED = 150.0
var current_speed = NORMAL_SPEED

var summoning_circle_ref: Node2D

func _ready() -> void:
	Globals.player_health = starting_health
	Globals.player_health_changed.connect(_on_player_health_changed)


func _physics_process(delta: float) -> void:
	if Globals.player_health <= 0:
		return
	
	if Input.is_action_pressed("Shoot"):
		shoot_bullet()
	
	if Input.is_action_pressed("Summon"):
		current_speed = FOCUS_SPEED
		summon_tick()
	else:
		current_speed = NORMAL_SPEED

	var direction := Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down"))
	velocity = direction * current_speed

	move_and_slide()

# Called when colliding with something for any reason.
func _collision(other: PhysicsBody2D) -> void:
	pass


func summon_tick():
	var player_brush_pos_diff = global_position.distance_to(brush_pos)
	if player_brush_pos_diff < brush_circle_radius:
		return
	else:
		if Globals.summon_ink > 0:
			var v = global_position - brush_pos
			brush_pos += v.normalized() * (player_brush_pos_diff - brush_circle_radius)
			var new_summoning_dust = summoning_dust.instantiate()
			var summoning_dust_pos = brush_pos
			#bullet_pos.y -= 50
			new_summoning_dust.set_position(summoning_dust_pos)
			self.get_parent().add_child(new_summoning_dust)
			Globals.summon_ink -= 1
		else:
			summoning_circle_ref.out_of_juice()
			Globals.summon_ink = 100

func shoot_bullet():
	if refire_delay_timer.is_stopped():
		BulletSpawner.fire_one_straight(
			self, bullet_scene,
			$bullet_spawn_location.position,
			$bullet_spawn_location.rotation)
		refire_delay_timer.start()

func _on_player_health_changed() -> void:
	if Globals.player_health <= 0 && $DeathTimer.is_stopped():
		#TODO death SFX
		$DeathTimer.start()
		$DeathParticles.emitting = true


func _on_death_timer_timeout() -> void:
	$DeathParticles.emitting = false
	player_died.emit()
