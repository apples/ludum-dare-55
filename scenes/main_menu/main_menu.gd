extends Control

@onready var start_game_button: Button = %StartGameButton
@onready var how_to_play_button: Button = %HowToPlayButton
@onready var options_button: Button = %OptionsButton
var options_scene = preload("res://scenes/options_menu/options_menu.tscn") 
var how_to_play_scene = preload("res://scenes/how_to_play/how_to_play.tscn") 

func _ready() -> void:
	start_game_button.grab_focus()
	MusicMan.music(  preload("res://sfx/hjr_undersea_scramble.ogg"), DataStore.current.music_volume)


func _on_start_game_button_pressed() -> void:
	SceneGirl.change_scene("res://scenes/level_select/level_select.tscn")


func _on_how_to_play_button_pressed() -> void:
	var os = how_to_play_scene.instantiate()
	get_tree().root.add_child(os)
	os.tree_exited.connect(_return_from_how_to_play)

func _on_options_button_pressed() -> void:
	var os = options_scene.instantiate()
	get_tree().root.add_child(os)
	os.tree_exited.connect(_return_from_options)


func _on_start_game_button_mouse_entered() -> void:
	start_game_button.grab_focus()


func _on_how_to_play_button_mouse_entered() -> void:
	how_to_play_button.grab_focus()


func _on_options_button_mouse_entered() -> void:
	options_button.grab_focus()

func _return_from_options()->void:
	options_button.grab_focus()
	
func _return_from_how_to_play()->void:
	how_to_play_button.grab_focus()
