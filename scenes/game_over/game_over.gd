extends Control

@onready var retry_button: Button = %RetryButton
@onready var main_menu_button: Button = %MainMenuButton


func _ready() -> void:
	retry_button.grab_focus()


func _on_retry_button_pressed() -> void:
	SceneGirl.change_scene("res://scenes/main_gameplay/main_gameplay.tscn")


func _on_retry_button_mouse_entered() -> void:
	retry_button.grab_focus()


func _on_main_menu_button_pressed() -> void:
	SceneGirl.change_scene("res://scenes/main_menu/main_menu.tscn")


func _on_main_menu_button_mouse_entered() -> void:
	main_menu_button.grab_focus()
