extends Resource

class_name BulletResource

@export var pattern: BulletSpawner.Pattern
@export var type: PackedScene
@export var element: Globals.Elements
@export var speed: float = 6.0
@export var speen: float = 5.0
@export var size: float = 1.0
@export var sprite_size: float = 1.0
@export var sprite: SpriteFrames = null
@export var z_index: int = 80
@export var secondary: BulletResource

func shoot(
	caller: Node2D,
	offset: Vector2,
	angle: float) -> void:
	
	if pattern == BulletSpawner.Pattern.UNSET or type == null:
		return
	
	BulletSpawner.fire_pattern(pattern, type, element, secondary, caller, offset, angle, speed, speen, size, sprite, sprite_size, z_index)
