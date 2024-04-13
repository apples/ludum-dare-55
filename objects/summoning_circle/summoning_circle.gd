extends Node2D

var player_ref: CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func out_of_juice():
	print("yoinks!")
	$Candle1.deactivate_candle()
	$Candle2.deactivate_candle()
	$Candle3.deactivate_candle()
	$Candle4.deactivate_candle()
	$Candle5.deactivate_candle()
