extends ProgressBar

@export var duration: int = 20

signal on_completed

# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = get_tree().create_tween()
	tween.tween_property(self, "value", self.max_value, duration)
	tween.tween_callback(_finish)

func _finish():
	on_completed.emit()
