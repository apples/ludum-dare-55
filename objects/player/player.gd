extends CharacterBody2D
var bullet_scene = preload("res://objects/bullet/bullet.tscn")
var summoning_dust = preload("res://objects/summoning_dust/summoning_dust.tscn")

const SPEED = 300.0


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
	var new_summoning_dust = summoning_dust.instantiate()
	var summoning_dust_pos = self.get_position()
	#bullet_pos.y -= 50
	new_summoning_dust.set_position(summoning_dust_pos)
	self.get_parent().add_child(new_summoning_dust)

func shoot_bullet():
	var new_bullet = bullet_scene.instantiate()
	var bullet_pos = self.get_position()
	bullet_pos.y -= 50
	new_bullet.set_position(bullet_pos)
	self.get_parent().add_child(new_bullet)
