class_name Kid
extends CharacterBody2D

@export var movement_speed: float = 4.0
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func set_movement_target(movement_target: Vector2):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		sprite.play('default')
		return

	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var current_agent_position: Vector2 = global_position
	var new_velocity: Vector2 = (next_path_position - current_agent_position).normalized() * movement_speed

	velocity = new_velocity
	move_and_slide()
	
	sprite.play('walking')
	sprite.flip_h = new_velocity.x < 0