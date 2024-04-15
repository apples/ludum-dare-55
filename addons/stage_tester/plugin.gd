@tool
extends EditorPlugin

var button

func _enter_tree() -> void:
	button = Button.new()
	button.icon = EditorInterface.get_editor_theme().get_icon("PlayStart", "EditorIcons")
	button.text = "Test Phase"
	button.tooltip_text = "Test Current Phase"
	var key = InputEventKey.new()
	key.keycode = KEY_F4
	button.shortcut = Shortcut.new()
	button.shortcut.events.append(key)
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, button)
	var container = button.get_parent()
	container.move_child(button, container.get_child_count() - 3)
	
	button.pressed.connect(_on_button_pressed)


func _exit_tree() -> void:
	if button:
		button.queue_free()


func _on_button_pressed() -> void:
	var test_scene = EditorInterface.get_edited_scene_root().scene_file_path
	if not test_scene:
		return
	OS.set_environment("LD55_TEST_STAGE_PHASE", test_scene)
	EditorInterface.play_custom_scene("res://scenes/main_gameplay/main_gameplay.tscn")
	OS.unset_environment("LD55_TEST_STAGE_PHASE")

