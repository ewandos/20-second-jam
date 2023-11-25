extends Node2D

@export var kid_count := 1
@export var monster_count := 1

@onready var monster_spawner := $MonsterSpawner as ObjectSpawner
@onready var kid_spawner := $KidSpawner as ObjectSpawner

var kids: Array[Node2D]

func _ready() -> void:
	for i in kid_count:
		var kid = kid_spawner.spawn_object()
		kids.append(kid)
	
	for i in monster_count:
		var monster = monster_spawner.spawn_object() as Monster
		monster.setup(kids)
