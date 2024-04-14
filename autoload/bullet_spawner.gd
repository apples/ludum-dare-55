extends Node

class_name BulletSpawner

static func fire_one_straight(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
	var scene = caller.get_tree().get_root()
	
	var transform = caller.global_transform
	transform = transform.scaled(Vector2.ONE)
	transform = transform.translated_local(offset)
	transform = transform.rotated_local(angle)
	
	var bullet = bullet_type.instantiate()
	bullet.global_transform = transform
	bullet.allegiance = _team(caller)
	bullet.element = _element(caller)
	scene.add_child(bullet)

static func fire_two_straight(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
	var scene = caller.get_tree().get_root()
	
	var transform = caller.global_transform
	transform = transform.scaled(Vector2.ONE)
	transform = transform.translated_local(offset)
	transform = transform.rotated_local(angle)
	
	var bullet = bullet_type.instantiate()
	bullet.global_transform = transform.translated_local(Vector2i(-25, 0))
	bullet.allegiance = _team(caller)
	bullet.element = _element(caller)
	scene.add_child(bullet)
	
	bullet = bullet_type.instantiate()
	bullet.global_transform = transform.translated_local(Vector2i(25, 0))
	bullet.allegiance = _team(caller)
	bullet.element = _element(caller)
	scene.add_child(bullet)

static func fire_three_arc(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
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
		bullet.allegiance = _team(caller)
		bullet.element = _element(caller)
		scene.add_child(bullet)
		
		await caller.get_tree().create_timer(0.033333).timeout

static func fire_three_arc_immediate(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
	var scene = caller.get_tree().get_root()
	
	for i in range(3):
		var transform = caller.global_transform
		
		transform = transform.scaled(Vector2.ONE)
		transform = transform.rotated_local(deg_to_rad(-15 + i * 15))
		transform = transform.translated_local(offset)
		transform = transform.rotated_local(angle)
		
		var bullet = bullet_type.instantiate()
		bullet.global_transform = transform
		bullet.allegiance = _team(caller)
		bullet.element = _element(caller)
		scene.add_child(bullet)

static func fire_five_arc(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
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
		bullet.allegiance = _team(caller)
		bullet.element = _element(caller)
		scene.add_child(bullet)
		
		await caller.get_tree().create_timer(0.02).timeout

static func fire_circle(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
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
		bullet.allegiance = _team(caller)
		bullet.element = _element(caller)
		scene.add_child(bullet)

static func fire_spiral(
	caller: Node2D,
	bullet_type: PackedScene,
	offset: Vector2,
	angle: float) -> void:
	
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
		bullet.allegiance = _team(caller)
		bullet.element = _element(caller)
		scene.add_child(bullet)
		
		await caller.get_tree().create_timer(0.01).timeout


static func _team(caller: Node2D) -> Bullet.Team:
	if caller is Bullet:
		return caller.allegiance
	elif caller.is_in_group("Player"):
		return Bullet.Team.PLAYER
	else:
		return Bullet.Team.ENEMY

static func _element(caller: Node2D) -> Globals.Elements:
	if caller is Player:
		return caller.current_element
	elif caller is Bullet:
		return caller.element
	return Globals.Elements.UNSET
