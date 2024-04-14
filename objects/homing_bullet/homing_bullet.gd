extends Bullet

const WAIT_TO_HOME: float = 0.1
const STOP_HOMING_TIME: float = 1.0
var homing: bool = false
var homing_target: Node2D = null

func _ready() -> void:
	await get_tree().create_timer(WAIT_TO_HOME).timeout
	
	var closest_node = find_closest_node()
	if closest_node != null:
		homing_target = closest_node
		homing = true
		await get_tree().create_timer(STOP_HOMING_TIME).timeout
		homing = false

func _process(delta: float) -> void:
	if homing and is_instance_valid(homing_target):
		var angle_to_target = global_position.angle_to_point(homing_target.global_position)
		global_rotation = lerp_angle(global_rotation, angle_to_target, 0.25)
	
	super(delta)

func find_closest_node() -> Node2D:
	var group: String
	if allegiance == Team.PLAYER:
		group = "Enemy"
	elif allegiance == Team.ENEMY:
		group = "Player"
	
	var nodes = get_tree().get_nodes_in_group(group)

	var closest_node: Node2D = null
	var closest_distance: float = 1.79769e308
	for node: Node2D in nodes:
		var distance = global_position.distance_squared_to(node.global_position)
		if distance < closest_distance:
			closest_distance = distance
			closest_node = node
	
	return closest_node
