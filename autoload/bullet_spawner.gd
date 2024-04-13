extends Node

class_name BulletSpawner

static func fire_one_straight(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
	var scene = caller.get_tree().get_root()
	
	var transform = caller.global_transform
	transform = transform.scaled(Vector2(1, 1))
	transform = transform.translated_local(offset)
	transform = transform.rotated_local(angle)
	
	var bullet = bullet_type.instantiate()
	bullet.global_transform = transform
	scene.add_child(bullet)

static func fire_two_straight(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
	var scene = caller.get_tree().get_root()
	
	var transform = caller.global_transform
	transform = transform.scaled(Vector2(1, 1))
	transform = transform.translated_local(offset)
	transform = transform.rotated_local(angle)
	
	var bullet = bullet_type.instantiate()
	bullet.global_transform = transform.translated_local(Vector2i(-25, 0))
	scene.add_child(bullet)
	
	bullet = bullet_type.instantiate()
	bullet.global_transform = transform.translated_local(Vector2i(25, 0))
	scene.add_child(bullet)

static func fire_three_straight(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
	var scene = caller.get_tree().get_root()
	
	var transform = caller.global_transform
	transform = transform.scaled(Vector2(1, 1))
	transform = transform.translated_local(offset)
	transform = transform.rotated_local(angle)
	
	var bullet = bullet_type.instantiate()
	bullet.global_transform = transform
	scene.add_child(bullet)
	
	bullet = bullet_type.instantiate()
	bullet.global_transform = transform.translated_local(Vector2i(50, 0))
	scene.add_child(bullet)
	
	bullet = bullet_type.instantiate()
	bullet.global_transform = transform.translated_local(Vector2i(-50, 0))
	scene.add_child(bullet)

static func fire_three_arc(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
	var scene = caller.get_tree().get_root()
	
	var transform = caller.global_transform
	transform = transform.scaled(Vector2(1, 1))
	transform = transform.translated_local(offset)
	transform = transform.rotated_local(angle)
	
	var bullet = bullet_type.instantiate()
	bullet.global_transform = transform
	scene.add_child(bullet)
	
	bullet = bullet_type.instantiate()
	bullet.global_transform = transform.rotated_local(deg_to_rad(-15))
	scene.add_child(bullet)
	
	bullet = bullet_type.instantiate()
	bullet.global_transform = transform.rotated_local(deg_to_rad(15))
	scene.add_child(bullet)
