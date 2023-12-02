extends HBoxContainer

@export var duration: int = 20

@onready var progress_bar := $ProgressBar as ProgressBar

signal on_completed

func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(progress_bar, "value", progress_bar.max_value, duration)
	tween.tween_callback(_finish)

func _finish():
	on_completed.emit()
