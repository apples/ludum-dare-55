extends Control

@onready var start_game_button: Button = %StartGameButton
@onready var how_to_play_button: Button = %HowToPlayButton
@onready var options_button: Button = %OptionsButton
var options_scene = preload("res://scenes/options_menu/options_menu.tscn") 

func _ready() -> void:
	start_game_button.grab_focus()
	MusicMan.music(  preload("res://sfx/hjr_undersea_scramble.ogg"), DataStore.current.music_volume)


func _on_start_game_button_pressed() -> void:
	SceneGirl.change_scene("res://scenes/level_select/level_select.tscn")


func _on_how_to_play_button_pressed() -> void:
	pass # Replace with function body.

func _on_options_button_pressed() -> void:
	get_tree().root.add_child(options_scene.instantiate())


func _on_start_game_button_mouse_entered() -> void:
	start_game_button.grab_focus()


func _on_how_to_play_button_mouse_entered() -> void:
	how_to_play_button.grab_focus()


func _on_options_button_mouse_entered() -> void:
	options_button.grab_focus()

