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
var player_health: int = 5:
	set(v):
		if player_invuln > 0:
			#push_error("Player health cannot be changed while invuln")
			#breakpoint
			return
		player_health = v;
		player_health_changed.emit();
		changed.emit()

var player_invuln: int = 0:
	set(v): player_invuln = v; changed.emit()

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

var main_gameplay_stage: Stage = null:
	set(v): main_gameplay_stage = v; changed.emit()

func _ready() -> void:
	reset()
	
	if OS.has_environment("LD55_TEST_STAGE_PHASE"):
		var test_stage_phase = OS.get_environment("LD55_TEST_STAGE_PHASE")
		var phase_scene: PackedScene = load(test_stage_phase)
		if not phase_scene:
			push_error("Invalid test stage phase: '", test_stage_phase, "'")
			breakpoint
			return
		var stage_phase = Phase.new()
		stage_phase.stage_phase = phase_scene
		stage_phase.enemy_resource = load([
			"res://objects/enemy/resources/fire_fesh.tres",
			"res://objects/enemy/resources/vegan_fosh.tres",
			"res://objects/enemy/resources/water_fush.tres",
		].pick_random())
		main_gameplay_stage = Stage.new()
		main_gameplay_stage.stage_name = "Test"
		main_gameplay_stage.phases.append(stage_phase)
		print_rich("[color=green]LOADED TEST PHASE:[/color] %s" % [test_stage_phase])

## Reset most variables to their default state.
func reset():
	player_invuln = 0
	player_health = 5
	player_pos = Vector2.ZERO
	score = 0
	summon_ink = 100
	boss_max_health = 100
	boss_health = boss_max_health
	#main_gameplay_stage = null

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

#top is weak to bottom
enum Elements {
	UNSET,
	FIRE,
	WATER,
	VEGANS,
}

#need this order if we go back to 5 elements:
#UNSET,
#AIR,
#WATER,
#VEGANS,
#DARK,
#FIRE,
