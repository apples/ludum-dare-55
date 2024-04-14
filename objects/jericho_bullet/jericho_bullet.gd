extends Bullet

class_name BombBullet

var homing_bullet_scene = preload("res://objects/homing_bullet/homing_bullet.tscn")

func _on_hitbox_body_entered(body: Node2D) -> void:
	$ExplodeTimer.stop()
	super(body)
	explode()

func _on_explode_timer_timeout() -> void:
	explode()
	queue_free()

func explode() -> void:
	BulletSpawner.fire_three_arc_immediate(
		self,
		homing_bullet_scene,
		Vector2.UP * 10,
		0
	)
