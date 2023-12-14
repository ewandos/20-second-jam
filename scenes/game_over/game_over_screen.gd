extends Control

@onready var continue_button := $ContinueButton as Button

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	continue_button.pressed.connect(on_continue_button_pressed)

func on_continue_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/start_screen/start_screen.tscn")
