extends Node2D

const SPEED = 12.0
var diretion := Vector2(0, -1)
var damage := 1

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	position += diretion * SPEED

func _on_hitbox_body_entered(body: Node2D) -> void:
	print("Hit???")
	if body.is_in_group("Enemy"):
		body.hit(damage)
		queue_free()
	elif body.is_in_group("Wall"):
		queue_free()
	else:
		print("nope")
	
