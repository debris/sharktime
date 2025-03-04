@tool
extends BodyMovement
class_name BodyMovementSwim

@export var target_position: Vector2 = Vector2.ZERO: set = set_target_position
@export var speed: float = 400.0

func set_target_position(value: Vector2):
	target_position = value

func _move_body(body: Body, delta: float):
	var segments = body.get_segments()
	var head = segments[0]
	var angle = atan2(target_position.y - head.position.y, target_position.x - head.position.x)
	var delta_angle = angle - head.rotation

	while delta_angle < -PI:
		delta_angle += 2 * PI

	while delta_angle > PI:
		delta_angle -= 2 * PI

	var new_rotation = head.rotation + delta_angle * delta * 2.0 * body.speed_multiplier
	head.rotation = new_rotation

	# calculate the motion
	var motion = Vector2.ZERO
	motion.x = speed * cos(head.rotation) * delta * body.speed_multiplier
	motion.y = speed * sin(head.rotation) * delta * body.speed_multiplier

	if body.character_body != null:
		body.character_body.position = head.position

		# collisions
		var collision = body.character_body.move_and_collide(motion)

		if collision:
			var collision_normal = collision.get_normal()
			var remaining_motion = collision.get_remainder()
			var slide_motion = remaining_motion.slide(collision_normal)
			body.character_body.position += slide_motion
		else:
			body.character_body.position += motion

		head.position = body.character_body.position
	else:
		head.position += motion
	
	# pull the segments
	for i in segments.size() - 1:
		var current = segments[i + 1]
		var prev = segments[i]

		current.rotation = atan2(prev.position.y - current.position.y, prev.position.x - current.position.x)
		var direction = current.position.direction_to(prev.position)
		current.position = prev.position - direction * current.distance_constraint

	body.queue_redraw()
