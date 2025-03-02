@tool
extends Node2D
class_name Body

@export var movement: BodyMovement:
	set(value):
		movement = value
		queue_redraw()

@export var drawer: BodyDrawer:
	set(value):
		drawer = value
		queue_redraw()
		for segment: Segment in get_segments():
			segment.queue_redraw()

func get_segments() -> Array:
	return get_children().filter(func(child):
		return child is Segment	&& child.visible
	)

func _process(delta: float) -> void:
	if movement != null:
		movement._move_body(self, delta)

func _draw() -> void:
	if drawer != null:
		drawer._draw_body(self)
