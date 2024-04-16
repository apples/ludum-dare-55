extends Node2D
class_name Bullet

enum Team {
	PLAYER,
	ENEMY,
}

var damage := 1

@export var speed = 6.0
@export var speen = 5.0
@export var allegiance: Team = Team.PLAYER
@export var element: Globals.Elements = Globals.Elements.UNSET

@onready var sprite_2d: AnimatedSprite2D = $Sprite2D

var sprite_frames: SpriteFrames
var sprite_size: float = 1.0

func _ready() -> void:
	if sprite_frames:
		sprite_2d.sprite_frames = sprite_frames
	sprite_2d.scale = Vector2(sprite_size, sprite_size)
	if allegiance != Team.PLAYER:
		speed = speed / 2

func _process(delta: float) -> void:
	sprite_2d.rotation += speen * delta

func _physics_process(delta: float) -> void:
	transform = transform.translated_local(Vector2.RIGHT * speed)

func _on_hitbox_body_entered(body: Node2D) -> void:
	if allegiance == Team.PLAYER and body.is_in_group("Enemy"):
		body.hit(damage, element)
		queue_free()
	elif allegiance == Team.ENEMY and body.is_in_group("Player"):
		if Globals.haxor == 1:
			MusicMan.sfx(preload("res://sfx/player_hit.wav"))
		if Globals.player_invuln == 0:
			Globals.player_health -= damage
			queue_free()
	elif body.is_in_group("Wall"):
		queue_free()
