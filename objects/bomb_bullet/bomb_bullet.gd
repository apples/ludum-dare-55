extends Bullet

class_name JerichoBullet

var homing_bullet = preload("res://objects/homing_bullet/homing_bullet.tscn")

func _on_hitbox_body_entered(body: Node2D) -> void:
	$ExplodeTimer.stop()
	super(body)
	explode()

func _on_explode_timer_timeout() -> void:
	explode()
	queue_free()

func explode() -> void:
	BulletSpawner.fire_three_arc(
		self,
		homing_bullet,
		Vector2.ZERO,
		0
	)
