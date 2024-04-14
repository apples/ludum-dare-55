extends Control

@onready var heart_img = preload("res://icon.svg")
var hearts := []

func _ready() -> void:
	Globals.changed.connect(_on_possible_change)
	
	var temp_heart
	for i in Globals.player_health:
		temp_heart = Sprite2D.new()
		temp_heart.texture = heart_img
		add_child(temp_heart)
		temp_heart.scale = Vector2(.5, .5)
		temp_heart.position = Vector2(32 + (i * 64), 32)
		hearts.append(temp_heart)

func _on_possible_change():
	if Globals.player_health > hearts.size():
		var temp_heart
		for i in Globals.player_health - hearts.size():
			temp_heart = Sprite2D.new()
			temp_heart.texture = heart_img
			add_child(temp_heart)
			temp_heart.scale = Vector2(.5, .5)
			temp_heart.position = Vector2(32 + ((i + hearts.size()) * 64), 32)
			hearts.append(temp_heart)
	if Globals.player_health < hearts.size():
		var temp_heart
		for i in hearts.size() - Globals.player_health:
			temp_heart = hearts.pop_back()
			if temp_heart:
				temp_heart.queue_free()
