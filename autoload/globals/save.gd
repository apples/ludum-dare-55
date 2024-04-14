extends Node

const filename = "user://ld55_save.json"

var current: Dictionary

var _default_values := {
	levels_beaten = [], #0, A1, B1, A2, B2
	sigils_unlocked = [],
}

func _ready():
	reload()

func save():
	var data = JSON.stringify(current)
	var file = FileAccess.open(filename, FileAccess.WRITE)
	file.store_string(data)
	file.close()
	print("Game saved")

func reload():
	var file = FileAccess.open(filename, FileAccess.READ)
	if not file:
		current = _default_values.duplicate(true)
		print("No save game found")
		return
	var data = file.get_as_text()
	current = JSON.parse_string(data)
	
	if not "levels_beaten" in current or current.levels_beaten == null:
		current.levels_beaten = _default_values.levels_beaten.duplicate(true)
	if "sigils_unlocked" not in current or current.sigils_unlocked == null:
		current.sigils_unlocked = _default_values.sigils_unlocked.duplicate(true)
	
	print("Loaded save game: ", current)
