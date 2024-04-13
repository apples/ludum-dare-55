extends Node
@onready var enemy_damaged_timer = $EnemyDamagedTimer

func _on_timeout() -> void:
	self.queue_free()




func _ready() -> void: 
	enemy_damaged_timer.start()
