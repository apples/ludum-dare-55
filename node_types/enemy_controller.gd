class_name EnemyController
extends Node

signal action_completed

var _physics_process_func: Callable
var _target_data: Dictionary

var enemy_resource: EnemyResource
var player: Node2D
var shoot_timer: Timer

var position: Vector2:
	get: return get_parent().global_position
	set(v): get_parent().global_position = v

static func from(node: Node) -> EnemyController:
	if not node.has_meta("enemy_controller"):
		breakpoint
		return null
	var ec = node.get_meta("enemy_controller", null) as EnemyController
	if not ec:
		breakpoint
		return null
	return ec

func _enter_tree() -> void:
	get_parent().set_meta("enemy_controller", self)
	enemy_resource = get_parent().enemy_resource
	
	if enemy_resource.bullet_resource != null:
		shoot_timer = Timer.new()
		shoot_timer.wait_time = enemy_resource.initial_shoot_delay
		shoot_timer.one_shot = true
		shoot_timer.autostart = true
		shoot_timer.timeout.connect(_shoot)
		
		add_child(shoot_timer)

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

func _shoot():
	if shoot_timer.one_shot == true:
		shoot_timer.wait_time = enemy_resource.shoot_cooldown
		shoot_timer.one_shot = false
		shoot_timer.start()
		
	if not is_instance_valid(player):
		player = get_tree().get_nodes_in_group("Player")[0]
	
	if not is_instance_valid(player):
		return
	
	var parent: Node2D = get_parent()
	var global_angle_to_target = parent.global_position.angle_to_point(player.global_position)
	enemy_resource.bullet_resource.shoot(parent, Vector2.ZERO, global_angle_to_target)
