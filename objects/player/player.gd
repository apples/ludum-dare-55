extends CharacterBody2D

signal player_died

@export var starting_health: int = 1

var bullet_scene = preload("res://objects/bullet/bullet.tscn")
var summoning_dust = preload("res://objects/summoning_dust/summoning_dust.tscn")

@onready var brush_pos = self.global_position #Vector2(0, 0)
const brush_circle_radius = 25

const SPEED = 300.0

func _ready() -> void:
	Globals.player_health = starting_health
	Globals.player_health_changed.connect(_on_player_health_changed)


func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("Shoot"):
		shoot_bullet()
	
	if Input.is_action_pressed("Summon"):
		summon_tick()

	var direction := Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down"))
	velocity = direction * SPEED

	move_and_slide()

# Called when colliding with something for any reason.
func _collision(other: PhysicsBody2D) -> void:
	pass


func summon_tick():
	var player_brush_pos_diff = global_position.distance_to(brush_pos)
	if player_brush_pos_diff < brush_circle_radius:
		return
	else:
		var v = global_position - brush_pos
		brush_pos += v.normalized() * (player_brush_pos_diff - brush_circle_radius)
		var new_summoning_dust = summoning_dust.instantiate()
		var summoning_dust_pos = brush_pos
		#bullet_pos.y -= 50
		new_summoning_dust.set_position(summoning_dust_pos)
		self.get_parent().add_child(new_summoning_dust)

func shoot_bullet():
	BulletSpawner.fire_circle(
		self, bullet_scene,
		$bullet_spawn_location.position,
		$bullet_spawn_location.rotation)

func _on_player_health_changed() -> void:
	if Globals.player_health <= 0:
		# TODO: Play a death animation
		player_died.emit()
