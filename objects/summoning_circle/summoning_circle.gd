extends Node2D

var player_ref: CharacterBody2D
var sigil_sequence_active = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Candle1.summoning_circle_ref = self
	$Candle2.summoning_circle_ref = self
	$Candle3.summoning_circle_ref = self
	$Candle4.summoning_circle_ref = self
	$Candle5.summoning_circle_ref = self


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func reset_summoning_circle():
	Globals.summon_ink = 100
	sigil_sequence_active = false
	$Candle1.deactivate_candle()
	$Candle2.deactivate_candle()
	$Candle3.deactivate_candle()
	$Candle4.deactivate_candle()
	$Candle5.deactivate_candle()
