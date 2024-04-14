extends Node
## An empty global variable bag with a togglable debug overlay that displays all variables.
##
## Designed to hold simple global variables.
## A bad pattern, but in a game jam, sometimes you just need to get it done.
##
## Displays a debug overlay when the user hits the F1 key.
## All variables are displayed automatically.

## Emitted when any variable changes.
signal changed

## Emitted when the player's health changes
signal player_health_changed

## Example variable.
var player_health: int = 3:
	set(v): player_health = v; player_health_changed.emit(); changed.emit()

var player_pos: Vector2 = Vector2.ZERO:
	set(v): player_pos = v; changed.emit()

var score: int = 0:
	set(v): score = v; changed.emit()

var summon_ink: float = 100:
	set(v): summon_ink = v; changed.emit()

var boss_max_health: int = 100:
	set(v): boss_max_health = v; changed.emit()

var boss_health: int = boss_max_health:
	set(v): boss_health = v; changed.emit()


## Reset all variables to their default state.
func reset():
	player_health = 0
	player_pos = Vector2.ZERO
	score = 0

#region Debug overlay
var _overlay
func _unhandled_key_input(event: InputEvent) -> void:
	if event.pressed:
		match event.physical_keycode:
			KEY_F1:
				if not _overlay:
					_overlay = load("res://autoload/globals/globals_overlay.tscn").instantiate()
					get_parent().add_child(_overlay)
				else:
					_overlay.visible = not _overlay.visible
#endregion
