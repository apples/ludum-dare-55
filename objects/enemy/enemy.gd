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
	enemy_damaged.position = self.position
	get_parent().get_parent().add_child(enemy_damaged)
