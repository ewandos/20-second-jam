extends Node2D

@export var kid_count := 1
@export var map: TileMap
@export var show_debug: bool

var kid_scene: PackedScene = preload('res://kid/kid.tscn')
var rng := RandomNumberGenerator.new()
var last_position := Vector2.ZERO



func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_A):
		spawn_kids()

func spawn_kids() -> void:
	for i in kid_count:
		var i_kid := kid_scene.instantiate() as Character
		add_child(i_kid)
		i_kid.global_position = _pick_random_walkable_position()
		i_kid.set_movement_target(_pick_random_walkable_position())

func _pick_random_walkable_position() -> Vector2:
	var possible_cells: Array[Vector2i]
	
	for cell_v in map.get_used_cells(0):
		
		## Vector2(2, 5) is the atlas coord for a walkable tile
		var is_walkable := map.get_cell_atlas_coords(0, cell_v) == Vector2i(2, 5)
		if is_walkable: possible_cells.append(cell_v)
	
	if possible_cells.size() == 0: return Vector2.ZERO
	
	var random_index = rng.randi_range(0, possible_cells.size() - 1)
	var random_cell := possible_cells[random_index]
	var random_position := map.map_to_local(random_cell)
	
	if show_debug:
		last_position = random_position
		queue_redraw()
	
	return random_position
	
func _draw() -> void:
	if not show_debug: return
	draw_circle(last_position, 1, Color.MAGENTA)
