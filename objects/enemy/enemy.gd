extends CharacterBody2D

var health = 1
var score_val = 10
var enemy_damaged_secene = preload("res://objects/VFX/enemy_damaged/enemy_damaged.tscn") 
var enemy_damaged= enemy_damaged_secene.instantiate()

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	pass

func hit(damage: int) -> void:
	health -= 1
	if health <= 0:
		queue_free()
	Globals.score += score_val
	enemy_damaged.position = self.position
	get_parent().get_parent().add_child(enemy_damaged)
