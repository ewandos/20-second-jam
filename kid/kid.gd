class_name Kid
extends Character

@onready var timer := $Timer as Timer

var _map: Map

func setup(map: Map) -> void:
	_map = map
	move_to_random_target()

func _ready() -> void:
	timer.timeout.connect(move_to_random_target)

func move_to_random_target() -> void:
	set_movement_target(_map.pick_random_walkable_position([Vector2i(2, 5)]))
	timer.start()