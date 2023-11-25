class_name ObjectSpawner
extends Node2D

@export var map: TileMap
@export var show_debug: bool
@export var atlas_coords: Array[Vector2i]
@export var object: PackedScene

var rng := RandomNumberGenerator.new()
var last_position := Vector2.ZERO

func spawn_object() -> void:
	var instance := object.instantiate()
	add_child(instance)
	instance.global_position = _pick_random_walkable_position()

func _pick_random_walkable_position() -> Vector2:
	var possible_cells: Array[Vector2i]
	
	for cell_v in map.get_used_cells(0):
		var is_walkable := is_valid_tile(map.get_cell_atlas_coords(0, cell_v))
		if is_walkable: possible_cells.append(cell_v)
	
	if possible_cells.size() == 0: return Vector2.ZERO
	
	var random_index = rng.randi_range(0, possible_cells.size() - 1)
	var random_cell := possible_cells[random_index]
	var random_position := map.map_to_local(random_cell)
	
	if show_debug:
		last_position = random_position
		queue_redraw()
	
	return random_position

func is_valid_tile(atlas_coord: Vector2i) -> bool:
	for coord in atlas_coords:
		if atlas_coord == coord: return true
	return false

func _draw() -> void:
	if not show_debug: return
	draw_circle(last_position, 1, Color.MAGENTA)
