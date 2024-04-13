extends CharacterBody2D
var bullet_scene = preload("res://objects/bullet/bullet.tscn")
var summoning_dust = preload("res://objects/summoning_dust/summoning_dust.tscn")

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
	var new_bullet = bullet_scene.instantiate()
	var bullet_pos = self.get_position()
	bullet_pos.y -= 50
	new_bullet.set_position(bullet_pos)
	self.get_parent().add_child(new_bullet)
