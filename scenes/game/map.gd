class_name Map
extends TileMap

var rng := RandomNumberGenerator.new()

func pick_random_walkable_position(valid_atlas_coords: Array[Vector2i]) -> Vector2:
	var possible_cells: Array[Vector2i] = []
	
	for cell_v in get_used_cells(0):
		var is_walkable := is_valid_tile(get_cell_atlas_coords(0, cell_v), valid_atlas_coords)
		if is_walkable: possible_cells.append(cell_v)
	
	if possible_cells.size() == 0: return Vector2.ZERO
	
	var random_index = rng.randi_range(0, possible_cells.size() - 1)
	var random_cell := possible_cells[random_index]
	var random_position := map_to_local(random_cell)
	
	return random_position

func is_valid_tile(current_coord: Vector2i, valid_coords: Array[Vector2i]) -> bool:
	for coord in valid_coords:
		if coord == current_coord: return true
	return false
