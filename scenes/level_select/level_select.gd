extends Node2D

@onready var first_level_button: TextureButton = $"0"

func _ready() -> void:
	first_level_button.grab_focus()
	if Save.current.levels_beaten.has("0"):
		$"A1".disabled = false
		$"B1".disabled = false
	if Save.current.levels_beaten.has("A1"):
		$"A2".disabled = false
	if Save.current.levels_beaten.has("B1"):
		$"B2".disabled = false


func _on_first_level_button_pressed() -> void:
	Globals.main_gameplay_stage = load("res://scenes/main_gameplay/stages/stage_1.tres")
	SceneGirl.change_scene("res://scenes/main_gameplay/main_gameplay.tscn")


func _on_b_1_pressed() -> void:
	pass # Replace with function body.

func _on_a_1_pressed() -> void:
	pass # Replace with function body.

func _on_b_2_pressed() -> void:
	pass # Replace with function body.

func _on_a_2_pressed() -> void:
	pass # Replace with function body.


