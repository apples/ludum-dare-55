class_name EnemyController
extends Node

signal action_completed

var _physics_process_func: Callable
var _target_data: Dictionary

var position: Vector2:
	get: return get_parent().global_position
	set(v): get_parent().global_position = v

static func from(node: Node) -> EnemyController:
	if not node.has_meta("enemy_controller"):
		return null
	return node.get_meta("enemy_controller", null) as EnemyController

func _enter_tree() -> void:
	get_parent().set_meta("enemy_controller", self)

func _exit_tree() -> void:
	if get_parent():
		get_parent().remove_meta("enemy_controller")

func kill() -> void:
	get_parent().queue_free()

func _physics_process(delta: float) -> void:
	if _physics_process_func: _physics_process_func.call(delta)

func move_to_point_with_speed(where: Vector2, speed: float) -> Signal:
	_target_data = { where = where, speed = speed }
	_physics_process_func = _move_to_point_with_speed_physics_process
	return action_completed

func move_to_point_over_time(where: Vector2, time: float) -> Signal:
	return move_to_point_with_speed(where, where.distance_to(position) / time)

func wait_for(time: float) -> Signal:
	get_tree().create_timer(time, true, true).timeout.connect(func ():
		action_completed.emit())
	return action_completed

func _move_to_point_with_speed_physics_process(delta: float) -> void:
	position = position.move_toward(_target_data.where, _target_data.speed * delta)
	if position.is_equal_approx(_target_data.where):
		action_completed.emit()
		_physics_process_func = Callable()

