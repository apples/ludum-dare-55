extends PanelContainer

@onready var level_button: Button = %LevelSelectButton
@onready var main_menu_button: Button = %MainMenuButton

func _ready() -> void:
	level_button.grab_focus()

func _on_main_menu_button_mouse_entered() -> void:
	main_menu_button.grab_focus()

func _on_level_select_button_mouse_entered() -> void:
	level_button.grab_focus()

func _on_main_menu_button_pressed() -> void:
	SceneGirl.change_scene("res://scenes/main_menu/main_menu.tscn")
	Globals.reset()

func _on_level_select_button_pressed() -> void:
	SceneGirl.change_scene("res://scenes/level_select/level_select.tscn")
	Globals.reset()
