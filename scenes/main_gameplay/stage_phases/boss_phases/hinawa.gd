extends StagePhase

@onready var boss: CharacterBody2D = $LuscaEnemy

var fire_speed = 17
var next_fire_frame = fire_speed
var angle = 0.0

func _ready() -> void:
	print("hi")
	enemies = [boss]
	boss.tree_exited.connect(func (): _goto("nothing"))
	_goto("1")

func _always_process(delta: float) -> void:
	super._process(delta)

func _always_physics_process(delta: float) -> void:
	pass

func construct_bullet(bullet: Bullet) -> void:
	bullet.allegiance = Bullet.Team.ENEMY

func _state_nothing_physics_process(delta: float) -> void:
	pass

func _state_1_physics_process(delta: float) -> void:
	next_fire_frame -= 1
	if next_fire_frame <= 0:
		next_fire_frame = fire_speed
		angle += TAU / 200.0
		BulletSpawner.fire_spiral(preload("res://objects/bullet/bullet.tscn"), boss, Vector2.ZERO, angle, construct_bullet)


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

