extends Node2D

var player_ref: Player
var camera_shake_ref: CameraShake
var sigil_sequence_active = false
var current_sigil_sequence = []
var sigil_scene = preload("res://objects/sigil/sigil.tscn")
var failed_sigil_scene = preload("res://objects/failed_sigil/failed_sigil.tscn")

var star_sigil_texture = preload("res://particles/star.png")
var circle_sigil_texture = preload("res://particles/circle_sigil.png")
var s_sigil_texture = preload("res://particles/s_sigil.png")
var w_sigil_texture = preload("res://particles/w_sigil.png")
var spiral_sigil_texture = preload("res://particles/spiral_sigil.png")


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
	if current_sigil_sequence == [4,1,3,5,2] or current_sigil_sequence == [2,5,3,1,4]:
		star_sigil()
		MusicMan.sfx(preload("res://sfx/summon_good.wav"))
	elif current_sigil_sequence == [3,4,5,1,2] or current_sigil_sequence == [2,1,5,4,3]:
		circle_sigil()
		MusicMan.sfx(preload("res://sfx/summon_good.wav"))
	elif current_sigil_sequence == [1,5,2,3,4] or current_sigil_sequence == [4,3,2,5,1]:
		s_sigil()
		MusicMan.sfx(preload("res://sfx/summon_good.wav"))
	elif current_sigil_sequence == [5,4,1,3,2] or current_sigil_sequence == [2,3,1,4,5]:
		w_sigil()
		MusicMan.sfx(preload("res://sfx/summon_good.wav"))
	elif current_sigil_sequence == [2,5,1,3,4] or current_sigil_sequence == [4,3,1,5,2]:
		spiral_sigil()
		MusicMan.sfx(preload("res://sfx/summon_good.wav"))
	#elif current_sigil_sequence == [5,4,3,2,1]:
		#vegan_sigil()
	#elif current_sigil_sequence == [4,3,5,2,1]:
		#dark_sigil()
	else:
		load_failed_sigil_vfx()
		camera_shake_ref.rumble(10, 1)
		MusicMan.sfx(preload("res://sfx/summon_bad.wav"))

func circle_sigil():
	player_ref.current_element = Globals.Elements.VEGANS
	player_ref.current_bullet_resource = preload("res://objects/bullet/resources/vegan_three.tres")
	load_sigil_vfx(circle_sigil_texture)

func s_sigil():
	player_ref.current_element = Globals.Elements.FIRE
	player_ref.current_bullet_resource = preload("res://objects/bullet/resources/fire_bomb.tres")
	load_sigil_vfx(s_sigil_texture)

func w_sigil():
	#player_ref.current_element = Globals.Elements.FIRE
	#player_ref.current_bullet_resource = preload("res://objects/bullet/resources/fire_bomb.tres")
	player_ref.current_element = Globals.Elements.WATER
	player_ref.current_bullet_resource = preload("res://objects/bullet/resources/water_five.tres")
	load_sigil_vfx(w_sigil_texture)

func star_sigil():
	for bullet in get_tree().get_nodes_in_group("Bullet"):
		bullet.queue_free()
	load_sigil_vfx(star_sigil_texture)


func spiral_sigil():
	for bullet in get_tree().get_nodes_in_group("Bullet"):
		bullet.queue_free()
	load_sigil_vfx(spiral_sigil_texture)

func load_sigil_vfx(sigil_texture):
	var new_sigil_vfx = sigil_scene.instantiate()
	new_sigil_vfx.sigil_texture = sigil_texture
	var sigil_sfx_pos = Vector2(500, 525)
	new_sigil_vfx.set_position(sigil_sfx_pos)
	self.get_parent().add_child(new_sigil_vfx)

func load_failed_sigil_vfx():
	var new_failed_sigil_vfx = failed_sigil_scene.instantiate()
	var failed_sigil_sfx_pos = global_position + Vector2(500, 535)
	new_failed_sigil_vfx.set_position(failed_sigil_sfx_pos)
	self.get_parent().add_child(new_failed_sigil_vfx)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_sigil_sequence.size() == 5:
		if $SigilCreatedTimer.is_stopped():
			check_sigil_sequence()
			$SigilCreatedTimer.start()


func reset_summoning_circle():
	#Globals.summon_ink = 100
	sigil_sequence_active = false
	current_sigil_sequence = []
	$Candle1.deactivate_candle()
	$Candle2.deactivate_candle()
	$Candle3.deactivate_candle()
	$Candle4.deactivate_candle()
	$Candle5.deactivate_candle()

func player_started_summoning():
	$Candle1.is_player_on_candle()
	$Candle2.is_player_on_candle()
	$Candle3.is_player_on_candle()
	$Candle4.is_player_on_candle()
	$Candle5.is_player_on_candle()

func _on_sigil_created_timer_timeout():
	#check_sigil_sequence()
	reset_summoning_circle()
