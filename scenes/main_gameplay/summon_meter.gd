extends ProgressBar

func _ready() -> void:
	Globals.changed.connect(_on_possible_change)
	
func _on_possible_change():
	value = Globals.summon_ink
