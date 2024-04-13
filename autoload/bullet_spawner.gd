extends Node

class_name BulletSpawner

static func fire_one_straight(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
	var scene = caller.get_tree().get_root()
	
	var bullet: Bullet = bullet_type.instantiate()
	
	var transform = caller.global_transform
	transform = transform.scaled(Vector2(1, 1))
	transform = transform.translated_local(offset)
	transform = transform.rotated_local(angle)
	
	scene.add_child(bullet)

	bullet.global_transform = transform
