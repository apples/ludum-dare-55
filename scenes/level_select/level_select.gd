extends Node2D

@onready var first_level_button: TextureButton = $"0"

func _ready() -> void:
	MusicMan.music(preload("res://sfx/hjr_aquatic_menu.ogg"), DataStore.current.music_volume)
	first_level_button.grab_focus()
	if Save.current.levels_beaten.has("0"):
		$"A1".disabled = false
		$"B1".disabled = false
	if Save.current.levels_beaten.has("Stage 1A"):
		$"A2".disabled = false
	if Save.current.levels_beaten.has("Stage 1B"):
		$"B2".disabled = false


func _on_first_level_button_pressed() -> void:
	Globals.main_gameplay_stage = preload("res://scenes/main_gameplay/stages/stage_0/stage_0.tres")
	SceneGirl.change_scene("res://scenes/main_gameplay/main_gameplay.tscn")


func _on_b_1_pressed() -> void:

	Globals.main_gameplay_stage = preload("res://scenes/main_gameplay/stages/stage_1b/stage_1b.tres")
	SceneGirl.change_scene("res://scenes/main_gameplay/main_gameplay.tscn")

func _on_a_1_pressed() -> void:
	Globals.main_gameplay_stage = preload("res://scenes/main_gameplay/stages/stage_a1/stage_1a.tres")
	SceneGirl.change_scene("res://scenes/main_gameplay/main_gameplay.tscn")

func _on_b_2_pressed() -> void:
	Globals.main_gameplay_stage = preload("res://scenes/main_gameplay/stages/stage_b2/stage_b2.tres")
	SceneGirl.change_scene("res://scenes/main_gameplay/main_gameplay.tscn")

func _on_a_2_pressed() -> void:
	Globals.main_gameplay_stage = preload("res://scenes/main_gameplay/stages/stage_a2/stage_a2.tres")
	SceneGirl.change_scene("res://scenes/main_gameplay/main_gameplay.tscn")


