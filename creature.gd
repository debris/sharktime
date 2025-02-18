@tool
extends Node2D
class_name Creature

@export var head_body: CharacterBody2D
@export var target_position: Vector2
@export var speed: float = 0.0
@export var speed_multiplier: float = 1.0

func get_segments() -> Array: 
	return get_children().filter(func(child):
		return child is Segment	&& child.visible
	)

func _process(delta: float) -> void:
	var segments = get_segments()
	var head = segments[0]
	var angle = atan2(target_position.y - head.position.y, target_position.x - head.position.x)
	var delta_angle = angle - head.rotation

	while delta_angle < -PI:
		delta_angle += 2 * PI

	while delta_angle > PI:
		delta_angle -= 2 * PI

	var new_rotation = head.rotation + delta_angle * delta * 2.0 * speed_multiplier
	head.rotation = new_rotation
	#head.rotation += delta_angle * delta * 2.0 * speed_multiplier
	
	head_body.position = head.position
	#head_body.rotation = head.rotation

	# calculate the motion
	var motion = Vector2.ZERO
	motion.x = speed * cos(head.rotation) * delta * speed_multiplier
	motion.y = speed * sin(head.rotation) * delta * speed_multiplier

	# calculate the collisions with other fish	
	var collision = head_body.move_and_collide(motion)
	if collision:
		var collision_normal = collision.get_normal()
		var remaining_motion = collision.get_remainder()
		var slide_motion = remaining_motion.slide(collision_normal)
		head_body.position += slide_motion
	else:
		head_body.position += motion

	head.position = head_body.position

	for i in segments.size() - 1:
		var current = segments[i + 1]
		var prev = segments[i]
		current.update_segment(prev)

	queue_redraw()

func _draw() -> void:
	return
