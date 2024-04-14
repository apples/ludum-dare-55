extends Node

class_name BulletSpawner

enum Pattern {
	UNSET,
	ONE_STRAIGHT,
	TWO_STRAIGHT,
	THREE_ARC,
	THREE_ARC_IMMEDIATE,
	FIVE_ARC,
	CIRCLE,
	SPIRAL
}

static func fire_pattern(
	pattern: Pattern,
	bullet_type: PackedScene,
	element: Globals.Elements,
	secondary_bullet: BulletResource,
	caller: Node2D,
	offset: Vector2,
	angle: float) -> void:
	
	var allegiance: Bullet.Team = _team(caller)
	var bullet_created: Callable = func(bullet: Bullet):
		bullet.allegiance = allegiance
		bullet.element = element
		
		if "secondary_bullet" in bullet:
			bullet.secondary_bullet = secondary_bullet
	
	match pattern:
		Pattern.ONE_STRAIGHT: fire_one_straight(bullet_type, caller, offset, angle, bullet_created)
		Pattern.TWO_STRAIGHT:fire_two_straight(bullet_type, caller, offset, angle, bullet_created)
		Pattern.THREE_ARC: fire_three_arc(bullet_type, caller, offset, angle, bullet_created)
		Pattern.THREE_ARC_IMMEDIATE: fire_three_arc_immediate(bullet_type, caller, offset, angle, bullet_created)
		Pattern.FIVE_ARC: fire_five_arc(bullet_type, caller, offset, angle, bullet_created)
		Pattern.CIRCLE: fire_circle(bullet_type, caller, offset, angle, bullet_created)
		Pattern.SPIRAL: fire_spiral(bullet_type, caller, offset, angle, bullet_created)

static func fire_one_straight(
	bullet_type: PackedScene,
	caller: Node2D,
	offset: Vector2,
	angle: float,
	bullet_created: Callable) -> void:
	
	var scene = caller.get_tree().get_root()
	
	var transform = caller.global_transform
	transform = transform.scaled(Vector2.ONE)
	transform = transform.translated_local(offset)
	transform = transform.rotated_local(angle)
	
	var bullet = bullet_type.instantiate()
	bullet.global_transform = transform
	bullet_created.call(bullet)
	scene.add_child(bullet)

static func fire_two_straight(
	bullet_type: PackedScene,
	caller: Node2D,
	offset: Vector2,
	angle: float,
	bullet_created: Callable) -> void:
	
	var scene = caller.get_tree().get_root()
	
	var transform = caller.global_transform
	transform = transform.scaled(Vector2.ONE)
	transform = transform.translated_local(offset)
	transform = transform.rotated_local(angle)
	
	var bullet = bullet_type.instantiate()
	bullet.global_transform = transform.translated_local(Vector2i(-25, 0))
	bullet_created.call(bullet)
	scene.add_child(bullet)
	
	bullet = bullet_type.instantiate()
	bullet.global_transform = transform.translated_local(Vector2i(25, 0))
	bullet_created.call(bullet)
	scene.add_child(bullet)

static func fire_three_arc(
	bullet_type: PackedScene,
	caller: Node2D,
	offset: Vector2,
	angle: float,
	bullet_created: Callable) -> void:
	
	var scene = caller.get_tree().get_root()
	
	for i in range(3):
		if not is_instance_valid(caller):
			return
		
		var transform = caller.global_transform
		
		transform = transform.scaled(Vector2.ONE)
		transform = transform.rotated_local(deg_to_rad(-15 + i * 15))
		transform = transform.translated_local(offset)
		transform = transform.rotated_local(angle)
		
		var bullet = bullet_type.instantiate()
		bullet.global_transform = transform
		bullet_created.call(bullet)
		scene.add_child(bullet)
		
		await caller.get_tree().create_timer(0.033333).timeout

static func fire_three_arc_immediate(
	bullet_type: PackedScene,
	caller: Node2D,
	offset: Vector2,
	angle: float,
	bullet_created: Callable) -> void:
	
	var scene = caller.get_tree().get_root()
	
	for i in range(3):
		var transform = caller.global_transform
		
		transform = transform.scaled(Vector2.ONE)
		transform = transform.rotated_local(deg_to_rad(-15 + i * 15))
		transform = transform.translated_local(offset)
		transform = transform.rotated_local(angle)
		
		var bullet = bullet_type.instantiate()
		bullet.global_transform = transform
		bullet_created.call(bullet)
		scene.add_child(bullet)

static func fire_five_arc(
	bullet_type: PackedScene,
	caller: Node2D,
	offset: Vector2,
	angle: float,
	bullet_created: Callable) -> void:
	
	var scene = caller.get_tree().get_root()
	
	for i in range(5):
		if not is_instance_valid(caller):
			return
		
		var transform = caller.global_transform
		
		transform = transform.scaled(Vector2.ONE)
		transform = transform.rotated_local(deg_to_rad(-22.5 + i * 11.25))
		transform = transform.translated_local(offset)
		transform = transform.rotated_local(angle)
		
		var bullet = bullet_type.instantiate()
		bullet.global_transform = transform
		bullet_created.call(bullet)
		scene.add_child(bullet)
		
		await caller.get_tree().create_timer(0.02).timeout

static func fire_circle(
	bullet_type: PackedScene,
	caller: Node2D,
	offset: Vector2,
	angle: float,
	bullet_created: Callable) -> void:
	
	var scene = caller.get_tree().get_root()
	
	var bullet_count = 8
	
	for i in range(bullet_count):
		var transform = caller.global_transform
		
		transform = transform.scaled(Vector2.ONE)
		transform = transform.rotated_local(deg_to_rad(360.0 / bullet_count * i))
		transform = transform.translated_local(offset)
		transform = transform.rotated_local(angle)
		
		var bullet = bullet_type.instantiate()
		bullet.global_transform = transform
		bullet_created.call(bullet)
		scene.add_child(bullet)

static func fire_spiral(
	bullet_type: PackedScene,
	caller: Node2D,
	offset: Vector2,
	angle: float,
	bullet_created: Callable) -> void:
	
	var scene = caller.get_tree().get_root()
	
	var bullet_count = 16
	
	for i in range(bullet_count):
		if not is_instance_valid(caller):
			return
		
		var transform = caller.global_transform
		
		transform = transform.scaled(Vector2.ONE)
		transform = transform.rotated_local(deg_to_rad(360.0 / bullet_count * i))
		transform = transform.translated_local(offset)
		transform = transform.rotated_local(angle)
		
		var bullet = bullet_type.instantiate()
		bullet.global_transform = transform
		bullet_created.call(bullet)
		scene.add_child(bullet)
		
		await caller.get_tree().create_timer(0.01).timeout


static func _team(caller: Node2D) -> Bullet.Team:
	if caller is Bullet:
		return caller.allegiance
	elif caller.is_in_group("Player"):
		return Bullet.Team.PLAYER
	else:
		return Bullet.Team.ENEMY
