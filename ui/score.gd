extends Label

func _ready() -> void:
	Globals.changed.connect(_on_possible_change)
	_on_possible_change()
	
func _on_possible_change():
	text = "SCORE: " + str(Globals.score)
