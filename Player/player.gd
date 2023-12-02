extends Sprite2D

@onready var damage_area_2d := $DamageArea2D as Area2D

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		kill_monster()

func _process(_delta):
	self.position = get_viewport().get_mouse_position()

func _on_damage_area_2d_area_entered(area: Monster) -> void:
	area.can_move = false

func _on_damage_area_2d_area_exited(area: Area2D) -> void:
	area.can_move = true

func kill_monster():
	global_scale *= 0.9 
	for monster in damage_area_2d.get_overlapping_areas():
		monster.queue_free()
