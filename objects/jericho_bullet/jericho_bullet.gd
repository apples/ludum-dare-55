extends Bullet

@export var secondary_bullet: BulletResource

func _on_hitbox_body_entered(body: Node2D) -> void:
	$ExplodeTimer.stop()
	super(body)
	explode()

func _on_explode_timer_timeout() -> void:
	explode()
	queue_free()

func explode() -> void:
	BulletSpawner.fire_pattern(
		BulletSpawner.Pattern.THREE_ARC_IMMEDIATE,
		secondary_bullet.type,
		secondary_bullet.element,
		secondary_bullet.secondary,
		self,
		Vector2.ZERO,
		0,
		secondary_bullet.speed,
		secondary_bullet.speen,
		secondary_bullet.size,
		secondary_bullet.sprite,
		secondary_bullet.sprite_size,
		secondary_bullet.z_index
	)
