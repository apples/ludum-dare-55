extends Node2D
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	#$Sprite2D.texture = "res://textures/41352_star_sigil.png"
	set_tween()
	tween.play()

func set_tween():
	tween = create_tween()
	tween.tween_property($Sprite2D, "modulate:a", 0, 1)
	tween.tween_callback(on_sigil_expires)
	tween.pause()
	
func on_sigil_expires():
	self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
