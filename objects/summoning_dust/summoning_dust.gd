extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	#$SummoningDustTimer.start()
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_summoning_dust_timer_timeout():
	self.queue_free()
	pass # Replace with function body.
