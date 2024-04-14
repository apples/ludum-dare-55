class_name StagePhase
extends Node2D

signal phase_complete

var enemies: Array[Node] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	for e in enemies:
		if is_instance_valid(e):
			return
	phase_complete.emit()
	queue_free()


func behavior_move_to_points(
		controller: EnemyController,
		points: Array[Vector2],
		move_time: float,
		pause_time: float,
		die_at_end: bool = false
	) -> void:
	for point in points:
		await controller.move_to_point_over_time(point, move_time)
		await controller.wait_for(pause_time)
	if die_at_end:
		controller.kill()
