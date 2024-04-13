extends CharacterBody2D
var bullet_scene = preload("res://Objects/bullet/bullet.tscn")

const SPEED = 300.0


func _physics_process(delta: float) -> void:

	if Input.is_action_just_pressed("Shoot"):
		shoot_bullet()

	var direction := Vector2(Input.get_axis("Left", "Right"), Input.get_axis("Up", "Down"))
	velocity = direction * SPEED

	move_and_slide()

# Called when colliding with something for any reason.
func _collision(other: PhysicsBody2D) -> void:
	pass

func shoot_bullet():
	BulletSpawner.fire_one_straight(self, bullet_scene, Vector2(0, -100), PI)
