extends Node

signal phase_complete

enum VSide {
	LEFT,
	RIGHT,
}

@export var dialog: VisualNovelDialog

var index := -1

var next_side: VSide = VSide.LEFT
var current_char = null

var text_tween: Tween

@onready var portrait_left: Sprite2D = %PortraitLeft
@onready var portrait_right: Sprite2D = %PortraitRight
@onready var text_panel: TextureRect = %TextPanel
@onready var text_label: RichTextLabel = %TextLabel

func _ready() -> void:
	if not dialog:
		queue_free()
	if get_tree().current_scene != self:
		get_tree().current_scene.process_mode = Node.PROCESS_MODE_DISABLED
	next_phrase()

func _exit_tree() -> void:
	if get_tree().current_scene:
		get_tree().current_scene.process_mode = Node.PROCESS_MODE_INHERIT

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Shoot"):
		if text_tween and text_tween.is_running():
			text_tween.custom_step(999.0)
		else:
			next_phrase()

func next_phrase() -> void:
	index += 1
	if index < dialog.phrases.size():
		var portrait = portrait_left
		if current_char != dialog.phrases[index].character:
			match next_side:
				VSide.LEFT:
					set_dim(portrait_left, false)
					set_dim(portrait_right, true)
					next_side = VSide.RIGHT
				VSide.RIGHT:
					set_dim(portrait_left, true)
					set_dim(portrait_right, false)
					next_side = VSide.LEFT
					portrait = portrait_right
		else:
			match next_side:
				VSide.LEFT:
					portrait = portrait_right
		match dialog.phrases[index].character:
			VisualNovelPhrase.Character.Olive:
				portrait.texture = preload("res://textures/olive_1.png")
			VisualNovelPhrase.Character.Lusca:
				portrait.texture = preload("res://textures/lusca_1.png")
			VisualNovelPhrase.Character.Gratin:
				portrait.texture = preload("res://textures/gratin_1.png")
		
		current_char = dialog.phrases[index].character
		
		text_label.text = dialog.phrases[index].rich_text
		
		text_tween = create_tween()
		text_label.visible_ratio = 0.0
		text_tween.tween_property(text_label, "visible_ratio", 1.0, 1.0)
	else:
		var t = create_tween()
		t.tween_property($CanvasModulate, "color", Color(0, 0, 0, 0), 1.0)
		t.finished.connect(func ():
			phase_complete.emit()
			queue_free())

func set_dim(portrait: Sprite2D, dim: bool) -> void:
	if dim:
		create_tween().tween_property(portrait, "scale", Vector2(0.9, 0.9), 0.2)
		create_tween().tween_property(portrait, "modulate", Color(0.5, 0.5, 0.5), 0.2)
	else:
		create_tween().tween_property(portrait, "scale", Vector2(1, 1), 0.2)
		create_tween().tween_property(portrait, "modulate", Color(1, 1, 1), 0.2)

