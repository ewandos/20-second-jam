class_name Monster
extends Character

@export var sprite_frames: Array[SpriteFrames]

var _targets: Array[Node2D]

func _ready() -> void:
	sprite.sprite_frames = sprite_frames.pick_random()

func setup(targets: Array[Node2D]):
	_targets = targets

func _process(_delta: float) -> void:
	
	var min_distance := INF
	var nearest_target: Node2D
	
	for target in _targets:
		var distance := global_position.distance_to(target.global_position)
		if distance < min_distance:
			min_distance = distance
			nearest_target = target
			
	if nearest_target == null: return
	
	set_movement_target(nearest_target.global_position)

func _on_area_entered(_area: Area2D) -> void:
	Events.game_over.emit()
