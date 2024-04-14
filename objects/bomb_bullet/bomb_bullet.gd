extends Bullet

class_name BombBullet

var bullet_scene = preload("res://objects/bullet/bullet.tscn")

func _on_hitbox_body_entered(body: Node2D) -> void:
	$ExplodeTimer.stop()
	super(body)
	explode()

func _on_explode_timer_timeout() -> void:
	explode()
	queue_free()

func explode() -> void:
	BulletSpawner.fire_circle(
		self,
		bullet_scene,
		Vector2.ZERO,
		0
	)
