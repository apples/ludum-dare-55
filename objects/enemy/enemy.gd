extends CharacterBody2D

@export var enemy_resource: EnemyResource = preload("res://objects/enemy/resources/shoot_and_scoot.tres")

@onready var health = enemy_resource.health
@onready var score_val = enemy_resource.score_value
@onready var element := enemy_resource.element

var enemy_damaged_secene = preload("res://objects/VFX/enemy_damaged/enemy_damaged.tscn") 
#var enemy_damaged = enemy_damaged_secene.instantiate()

@onready var outline = $Outline

func _ready() -> void:
	$Outline/AnimatedSprite2D.sprite_frames = enemy_resource.sprite_frames
	pass

func _process(delta: float) -> void:
	if element == Globals.Elements.FIRE:
		outline.material.set("shader_parameter/fillColor", Vector4(1, 0, 0, 1))
	if element == Globals.Elements.WATER:
		outline.material.set("shader_parameter/fillColor", Vector4(0, 0, 1, 1))
	if element == Globals.Elements.VEGANS:
		outline.material.set("shader_parameter/fillColor", Vector4(0, 1, 0, 1))
	#if element == Globals.Elements.AIR:
		#outline.material.set("shader_parameter/fillColor", Vector4(1, 1, 0, 1))
	#if element == Globals.Elements.DARK:
		#outline.material.set("shader_parameter/fillColor", Vector4(0.5, 0, 1, 1))
	if element == Globals.Elements.UNSET:
		outline.material.set("shader_parameter/fillColor", Vector4(0, 0, 0, 0))

func _physics_process(delta: float) -> void:
	pass

func hit(damage: int, element_type: Globals.Elements) -> void:
	var element_mod = 1
	if(element == Globals.Elements.UNSET || 
	element_type == Globals.Elements.UNSET || 
	element == element_type):
		pass
	else:
		var a = (Globals.Elements.size() - 2) / 2 # 1 if 3, 2 if 5
		var offset = a - element
		if (element_type + offset + Globals.Elements.size() - 1) % (Globals.Elements.size() - 1) > a:
			element_mod = 2
		else:
			element_mod = .5
	
	
	health -= damage * element_mod
	if health <= 0:
		queue_free()
	Globals.score += score_val
	var enemy_damaged = enemy_damaged_secene.instantiate()
	enemy_damaged.position = self.position
	get_parent().get_parent().add_child(enemy_damaged)
