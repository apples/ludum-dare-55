extends ColorRect

func _ready() -> void:
	Globals.changed.connect(_on_possible_change)
	
func _on_possible_change():
	scale = Vector2(Globals.boss_health as float / Globals.boss_max_health as float, 1)
