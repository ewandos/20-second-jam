class_name Game
extends Node2D

@export var kid_count := 1
@export var max_monsters := 1
@export var spawn_frequency := 1.0

@onready var monster_spawner := $MonsterSpawner as ObjectSpawner
@onready var kid_spawner := $KidSpawner as ObjectSpawner	
@onready var spawn_timer := $SpawnTimer as Timer
@onready var map := $Map as TileMap

var kids: Array[Node2D]
var monster_count := 0

enum EndState {
	WIN,
	LOOSE
}

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Events.game_over.connect(_on_game_over)

	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	spawn_timer.start(spawn_frequency)
	
	# Set environment clear color to black
	RenderingServer.set_default_clear_color(Color(0, 0, 0))
	
	# Spawn kids
	for i in kid_count:
		var kid := kid_spawner.spawn_object_on_random_location() as Kid
		kid.setup(map)
		kids.append(kid)

func _on_game_over() -> void:
	get_tree().change_scene_to_file("res://scenes/game_over/game_over_screen.tscn")

func _on_spawn_timer_timeout() -> void:
	var monster = monster_spawner.spawn_object_on_random_location()
	monster.setup(kids)
	monster_count += 1
	if max_monsters > monster_count:
		spawn_timer.start(spawn_frequency)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and event.keycode == KEY_ESCAPE:
		Events.game_over.emit()

func _on_timer_on_completed() -> void:
	Events.game_over.emit()
