@tool
extends Node2D
class_name Segment

@export var distance_constraint: float:
	set(value):
		distance_constraint = value
		queue_redraw()
		get_parent().queue_redraw()

@export var body_size: float:
	set(value):
		body_size = value
		queue_redraw()
		get_parent().queue_redraw()

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

	var parent = get_parent()
	if "drawer" in parent:
		parent.drawer._draw_segment(self)
