extends Node2D

var player_ref: CharacterBody2D
var sigil_sequence_active = false
var current_sigil_sequence = []


# Called when the node enters the scene tree for the first time.
func _ready():
	$Candle1.summoning_circle_ref = self
	$Candle1.index = 1
	$Candle2.summoning_circle_ref = self
	$Candle2.index = 2
	$Candle3.summoning_circle_ref = self
	$Candle3.index = 3
	$Candle4.summoning_circle_ref = self
	$Candle4.index = 4
	$Candle5.summoning_circle_ref = self
	$Candle5.index = 5

func push_active_candle(index: int):
	current_sigil_sequence.append(index)

func check_sigil_sequence():
	print(current_sigil_sequence)
	if current_sigil_sequence == [4,1,3,5,2]:
		trigger_41352_star_sigil()

func trigger_41352_star_sigil():
	print("that's a star yo")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_sigil_sequence.size() == 5:
		check_sigil_sequence()
		reset_summoning_circle()
		print("yooooo")

func reset_summoning_circle():
	Globals.summon_ink = 100
	sigil_sequence_active = false
	current_sigil_sequence = []
	$Candle1.deactivate_candle()
	$Candle2.deactivate_candle()
	$Candle3.deactivate_candle()
	$Candle4.deactivate_candle()
	$Candle5.deactivate_candle()
