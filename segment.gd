@tool
extends Node2D
class_name Segment

@export var distance_constraint: float
@export var body_size: float:
	set(value):
		body_size = value
		queue_redraw()
@export var should_draw: bool:
	set(value):
		should_draw = value
		queue_redraw()

func update_segment(prev: Segment):
	var angle = atan2(prev.position.y - position.y, prev.position.x - position.x)
	rotation = angle

	var direction = position.direction_to(prev.position)
	position = prev.position - direction * distance_constraint

func _draw() -> void:
	if !should_draw:
		return

	draw_circle(Vector2.ZERO, body_size, Color.WHITE, true, 2.0)
	draw_circle(Vector2.ZERO, body_size, Color.BLACK, false, 2.0)
	draw_line(Vector2.ZERO, Vector2(body_size, 0.0), Color.BLACK, 2.0)
