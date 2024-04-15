extends Node

@onready var return_button: Button = %ReturnButton


func _ready() -> void:
	self.process_mode= Node.PROCESS_MODE_ALWAYS
	%music_volume.value = DataStore.current.music_volume
	%master_volume.value = DataStore.current.master_volume
	%sfx_volume.value = DataStore.current.sfx_volume
	return_button.grab_focus()
func _on_master_volume_value_changed(value: float) -> void:
	print(value)
	DataStore.current.master_volume = value
	DataStore.save()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(value));


func _on_main_menu_button_pressed() -> void: 
	SceneGirl.change_scene("res://scenes/main_menu/main_menu.tscn")


func _on_mute_button_pressed() -> void:
	%master_volume.value = 0.00
	


func _on_music_volume_value_changed(value: float) -> void:
	print(value)
	DataStore.current.music_volume = value
	DataStore.save()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"),linear_to_db(value));


func _on_sfx_volume_value_changed(value: float) -> void:
	
	print(value)
	DataStore.current.sfx_volume = value
	DataStore.save()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"),linear_to_db(value));


func _on_return_button_pressed() -> void:
	self.queue_free()

