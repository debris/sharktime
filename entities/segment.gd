@tool
extends Node2D
class_name Segment

@export var distance_constraint: float:
	set(value):
		distance_constraint = value
		queue_redraw()
		if is_node_ready():
			get_parent().queue_redraw()

@export var body_size: float:
	set(value):
		body_size = value
		queue_redraw()
		if is_node_ready():
			get_parent().queue_redraw()

func _draw() -> void:
	var parent = get_parent()
	if "drawer" in parent:
		parent.drawer._draw_segment(self)
