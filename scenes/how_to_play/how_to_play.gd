extends Node


@onready var return_button: Button = %ReturnButton



func _ready() -> void:
	self.process_mode= Node.PROCESS_MODE_ALWAYS
	#return_button.grab_focus()
	




func _on_return_button_pressed() -> void:
	self.queue_free()
