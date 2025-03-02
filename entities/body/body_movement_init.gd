@tool
extends BodyMovement
class_name BodyMovementInit

func _move_body(body: Body, _delta: float):
	var segments = body.get_segments()
	for i in segments.size() - 1:
		var prev: Segment = segments[i]
		var current: Segment = segments[i + 1]
		current.position.x = prev.position.x - current.distance_constraint
	
	body.queue_redraw()
