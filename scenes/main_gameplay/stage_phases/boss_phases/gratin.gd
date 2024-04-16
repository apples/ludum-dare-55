extends StagePhase

const GRATIN_COMPLETE = preload("res://scenes/main_gameplay/stage_phases/boss_phases/gratin_complete.tscn")
const GRATIN_INTRO = preload("res://scenes/main_gameplay/stage_phases/boss_phases/gratin_intro.tscn")
const BOSS_INTRO = preload("res://scenes/main_gameplay/boss_intro.tscn")

@onready var boss: CharacterBody2D = $GratinEnemy

var angle = 0.0

var fire_rates = []
var fire_timers = []

var bi

func _ready() -> void:
	enemies = [boss]
	boss.tree_exited.connect(func (): _goto("E"))
	_goto("0")

func _always_process(delta: float) -> void:
	super._process(delta)

func _always_physics_process(delta: float) -> void:
	pass

func _state_nothing_physics_process(delta: float) -> void:
	pass

func _fire_timers() -> Array:
	var result = []
	for i in fire_timers.size():
		fire_timers[i] -= 1
		if fire_timers[i] <= 0:
			fire_timers[i] = fire_rates[i]
			result.append(true)
		else:
			result.append(false)
	return result

func _state_0_enter() -> void:
	bi = BOSS_INTRO.instantiate()
	bi.get_node("NameLabel").text = "GRATIN"
	get_parent().add_child(bi)
	fire_rates = [17, 53]
	fire_timers = fire_rates.duplicate()

func _state_0_physics_process(delta: float) -> void:
	boss.position = boss.position.move_toward(Vector2(920/2, 200), delta * 150.0)
	if boss.position.is_equal_approx(Vector2(920/2, 200)) and not is_instance_valid(bi):
		_goto("1")
		get_parent().add_child(GRATIN_INTRO.instantiate())

func _state_1_enter() -> void:
	fire_rates = [17, 93]
	fire_timers = fire_rates.duplicate()

func _state_1_physics_process(delta: float) -> void:
	if not boss or boss.health < 750:
		_goto("2")
		return
	
	angle += TAU / 200.0
	
	var fire = _fire_timers()
	
	if fire[0]:
		var b = BulletResource.new()
		b.pattern = BulletSpawner.Pattern.SPIRAL
		b.type = preload("res://objects/bullet/bullet.tscn")
		b.sprite = preload("res://particles/bullet_grey.tres")
		b.sprite_size = 1.5
		b.speed = 7
		b.speen = 0
		b.size = 1
		b.shoot(boss, Vector2.ZERO, angle)
	
	if fire[1]:
		var b = BulletResource.new()
		b.pattern = BulletSpawner.Pattern.ONE_STRAIGHT
		b.type = preload("res://objects/bullet/bullet.tscn")
		b.speed = 1
		b.speen = 0
		b.size = 5
		b.sprite_size = 1.0 / b.size
		b.z_index = 50
		b.sprite = preload("res://particles/big_shot.tres")
		var player = get_tree().get_nodes_in_group("Player")[0]
		assert(player)
		
		var global_angle_to_target = boss.global_position.angle_to_point(player.global_position)
		b.shoot(boss, Vector2.RIGHT.rotated(global_angle_to_target) * 100, global_angle_to_target)



func _state_2_enter() -> void:
	fire_rates = [120]
	fire_timers = fire_rates.duplicate()
	
	boss.element = Globals.Elements.WATER

func _state_2_exit() -> void:
	boss.element = Globals.Elements.UNSET

func _state_2_physics_process(delta: float) -> void:
	if not boss or boss.health < 500:
		_goto("3")
		return
	
	var fire = _fire_timers()
	
	if fire[0]:
		var b = BulletResource.new()
		b.pattern = BulletSpawner.Pattern.TWO_STRAIGHT
		b.type = preload("res://objects/bullet/bullet.tscn")
		b.speed = 8
		b.speen = 0
		b.size = 3
		b.sprite_size = 1.0 / b.size
		b.z_index = 60
		b.sprite = preload("res://particles/big_shot.tres")
		var player = get_tree().get_nodes_in_group("Player")[0]
		assert(player)
		
		var global_angle_to_target = boss.global_position.angle_to_point(player.global_position)
		b.shoot(boss, Vector2.RIGHT.rotated(global_angle_to_target) * 100, global_angle_to_target)




func _state_3_enter() -> void:
	fire_rates = [120]
	fire_timers = fire_rates.duplicate()

func _state_3_physics_process(delta: float) -> void:
	if not boss:
		_goto("E")
		return
	
	var fire = _fire_timers()
	
	if fire[0]:
		var b = BulletResource.new()
		b.pattern = BulletSpawner.Pattern.THREE_ARC
		b.type = preload("res://objects/bullet/bullet.tscn")
		b.speed = 5
		b.speen = 0
		b.size = 2
		b.sprite_size = 1.0 / b.size
		b.z_index = 60
		b.sprite = preload("res://particles/big_shot.tres")
		var player = get_tree().get_nodes_in_group("Player")[0]
		assert(player)
		
		var global_angle_to_target = boss.global_position.angle_to_point(player.global_position)
		b.shoot(boss, Vector2.RIGHT.rotated(global_angle_to_target) * 100, global_angle_to_target)




func _state_E_enter() -> void:
	get_parent().add_child(GRATIN_COMPLETE.instantiate())

func _state_E_process(delta: float) -> void:
	phase_complete.emit()
	queue_free()





#region State machine core
# do not touch please
var _states: Dictionary
var _current_state: StringName
func __opt_func(n: StringName) -> Callable:
	return Callable(self, n) if self.has_method(n) else Callable()
func _add_state(state_name: String) -> void:
	_states[state_name] = {
		process = __opt_func("_state_" + state_name + "_process"),
		physics_process = __opt_func("_state_" + state_name + "_physics_process"),
		enter = __opt_func("_state_" + state_name + "_enter"),
		exit = __opt_func("_state_" + state_name + "_exit") }
	if _states[state_name].values().count(Callable()) == 4:
		push_warning("State %s has no state functions! Typo?" % [state_name])
		breakpoint
func _goto(state_name: StringName) -> void:
	if _current_state == state_name:
		return
	if _current_state and _states[_current_state].get("exit", Callable()): _states[_current_state].exit.call()
	_current_state = state_name
	if not _current_state: return
	if not _current_state in _states: _add_state(_current_state)
	if _current_state and _states[_current_state].get("enter", Callable()): _states[_current_state].enter.call()
func _process(delta: float) -> void:
	if &"_always_process" in self: (self as Variant)._always_process(delta)
	if _current_state and _states[_current_state].get("process", Callable()): _states[_current_state].process.call(delta)
func _physics_process(delta: float) -> void:
	if &"_always_physics_process" in self: (self as Variant)._always_physics_process(delta)
	if _current_state and _states[_current_state].get("physics_process", Callable()): _states[_current_state].physics_process.call(delta)
#endregion

