extends Area2D
var summoning_circle_ref: Node2D
var active = false
var index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func activate_candle():
	$CandleLightSprite.frame = 1
	active = true

func deactivate_candle():
	$CandleLightSprite.frame = 0
	active = false

func is_player_on_candle():
	var bodies = self.get_overlapping_bodies()
	for n in range(bodies.size()):
		if bodies[n].name == "Player":
			trigger_activate_candle()

func _on_body_entered(body):
	if body.name == "Player" and Input.is_action_pressed("Summon") and !active:
		trigger_activate_candle()

func trigger_activate_candle():
	if Globals.summon_ink > 0:
		summoning_circle_ref.sigil_sequence_active = true
		summoning_circle_ref.push_active_candle(index)
		Globals.summon_ink += 15
		activate_candle()
