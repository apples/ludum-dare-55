extends Node2D
class_name Bullet

enum Team {
	PLAYER,
	ENEMY,
}

const SPEED = 12.0
var direction := Vector2(0, 1)
var damage := 1

@export var allegiance: Team = Team.PLAYER
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	sprite_2d.rotation += 5.0 * delta

func _physics_process(delta: float) -> void:
	transform = transform.translated_local(direction * SPEED)

func _on_hitbox_body_entered(body: Node2D) -> void:
	if allegiance == Team.PLAYER and body.is_in_group("Enemy"):
		body.hit(damage)
		queue_free()
	elif allegiance == Team.ENEMY and body.is_in_group("Player"):
		Globals.player_health -= damage
		queue_free()
	elif body.is_in_group("Wall"):
		queue_free()
