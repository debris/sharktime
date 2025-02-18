extends Node
class_name PlayerMovement

const SPEED = 300.0

@export var player: Area2D

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
	#	player.velocity.x = direction * SPEED
	#else:
	#	player.velocity.x = move_toward(player.velocity.x, 0, SPEED)

	#var direction_y := Input.get_axis("ui_up", "ui_down")
	#if direction_y:
	#	player.velocity.y = direction_y * SPEED
	#else:
	#	player.velocity.y = move_toward(player.velocity.y, 0, SPEED)


	#player.move_and_slide()
	player.position = player.get_global_mouse_position()
