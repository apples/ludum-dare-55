extends StagePhase

@onready var boss: CharacterBody2D = $LuscaEnemy

var angle = 0.0

var fire_rates = []
var fire_timers = []

func _ready() -> void:
	print("hi")
	enemies = [boss]
	boss.tree_exited.connect(func (): _goto("nothing"))
	_goto("1")

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

func _state_1_enter() -> void:
	fire_rates = [17, 53]
	fire_timers = fire_rates.duplicate()

func _state_1_physics_process(delta: float) -> void:
	angle += TAU / 200.0
	
	var fire = _fire_timers()
	
	if fire[0]:
		var b = BulletResource.new()
		b.pattern = BulletSpawner.Pattern.SPIRAL
		b.type = preload("res://objects/bullet/bullet.tscn")
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

