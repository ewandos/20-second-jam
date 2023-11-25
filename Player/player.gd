extends Node

func _process(delta):
	self.position = get_viewport().get_mouse_position()

