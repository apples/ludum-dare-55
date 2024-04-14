extends Node

func _ready() -> void:
	pass


func _on_master_volume_value_changed(value: float) -> void:
	print(value)
	DataStore.current.master_volume = value
	DataStore.save()
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),linear_to_db(value));
