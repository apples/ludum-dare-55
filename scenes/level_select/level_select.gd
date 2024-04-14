extends Node2D

@onready var first_level_button: TextureButton = $FirstLevelButton

func _ready() -> void:
	first_level_button.grab_focus()


func _on_first_level_button_pressed() -> void:
	SceneGirl.change_scene("res://scenes/main_gameplay/main_gameplay.tscn")


func _on_second_level_button_pressed() -> void:
	pass # Replace with function body.
