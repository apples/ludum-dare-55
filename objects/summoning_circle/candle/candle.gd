extends Node2D



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate_candle():
	$CandleLightSprite.frame = 1

func deactivate_candle():
	$CandleLightSprite.frame = 0

func _on_body_entered(body):
	if body.name == "Player" and Input.is_action_pressed("Summon"):
		if Globals.summon_ink > 0:
			Globals.summon_ink = 100
			activate_candle()
			# signal to summoning circle
