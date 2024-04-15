extends Node


@onready var resume_game_button: Button = %ResumeGameButton
@onready var how_to_play_button: Button = %HowToPlayButton
@onready var options_button: Button = %OptionsButton

var options_scene = preload("res://scenes/options_menu/options_menu.tscn") 


func _ready() -> void:
	self.process_mode= Node.PROCESS_MODE_ALWAYS
func _on_resume_game_button_pressed() -> void:
	get_tree().paused = false
	self.queue_free()


func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	self.queue_free()
	SceneGirl.change_scene("res://scenes/main_menu/main_menu.tscn")


func _on_options_button_pressed() -> void:
	get_tree().paused = true
	%PauseLayer.visible = false
	var os = options_scene.instantiate()
	get_tree().root.add_child(os)
	os.tree_exited.connect(_unhide_pause_menu)
func _unhide_pause_menu()->void:
	%PauseLayer.visible = true


