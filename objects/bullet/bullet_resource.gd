extends Resource

class_name BulletResource

@export var pattern: BulletSpawner.Pattern
@export var type: PackedScene
@export var element: Globals.Elements
@export var secondary: BulletResource

func shoot(
	caller: Node2D,
	offset: Vector2,
	angle: float) -> void:
	
	if pattern == BulletSpawner.Pattern.UNSET or type == null:
		return
	
	BulletSpawner.fire_pattern(pattern, type, element, secondary, caller, offset, angle)
