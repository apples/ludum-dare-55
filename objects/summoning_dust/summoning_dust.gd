extends Node2D
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	set_tween()

func set_tween():
	tween = create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 0, 0.5)
	tween.tween_callback(on_dust_expires)
	tween.pause()
	
func on_dust_expires():
	self.queue_free()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_summoning_dust_timer_timeout():
	tween.play()
	pass # Replace with function body.
