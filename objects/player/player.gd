extends CharacterBody2D

signal player_died

const SPEED = 300.0


func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("Shoot"):
		print("Bang")

	var direction := Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down"))
	velocity = direction * SPEED

	move_and_slide()

# Called when colliding with something for any reason.
func _collision(other: PhysicsBody2D) -> void:
	pass
