extends CharacterBody2D

var health = 1

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

