extends CharacterBody2D

var health = 1
var score_val = 10
var element := Globals.Elements.UNSET
var enemy_damaged_secene = preload("res://objects/VFX/enemy_damaged/enemy_damaged.tscn") 
var enemy_damaged= enemy_damaged_secene.instantiate()

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func hit(damage: int, element_type: Globals.Elements) -> void:
	var element_mod = 1
	if element == Globals.Elements.FIRE:
		if element_type == Globals.Elements.WATER:
			element_mod = 2
		elif element_type == Globals.Elements.VEGANS:
			element_mod = .5
	elif element == Globals.Elements.WATER:
		if element_type == Globals.Elements.VEGANS:
			element_mod = 2
		elif element_type == Globals.Elements.FIRE:
			element_mod = .5
	elif element == Globals.Elements.VEGANS:
		if element_type == Globals.Elements.FIRE:
			element_mod = 2
		elif element_type == Globals.Elements.WATER:
			element_mod = .5
	
	health -= damage * element_mod
	if health <= 0:
		queue_free()
	Globals.score += score_val
	enemy_damaged.position = self.position
	get_parent().get_parent().add_child(enemy_damaged)
