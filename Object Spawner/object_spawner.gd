class_name ObjectSpawner
extends Node2D

@export var map: TileMap
@export var object: PackedScene

## Atlas coords of tiles on which the objects can be spawned
@export var atlas_coords: Array[Vector2i]

func spawn_object_on_random_location() -> Node2D:
	var instance := object.instantiate()
	add_child(instance)
	instance.global_position = map.pick_random_walkable_position(atlas_coords)
	return instance

