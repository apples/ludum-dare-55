extends ColorRect

func _ready() -> void:
	Globals.changed.connect(_on_possible_change)
	
func _on_possible_change():
	var ratio : float = float(Globals.boss_health) / float(Globals.boss_max_health)
	scale = Vector2(ratio, 1)
	color = Color((1 - ratio) * 0.733, ratio * 0.733, 0)
