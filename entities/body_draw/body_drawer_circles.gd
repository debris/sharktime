@tool
extends BodyDrawer
class_name BodyDrawerCircles

func _draw_body(_body: Body):
	pass

func _draw_segment(segment: Segment):
	segment.draw_circle(Vector2.ZERO, segment.body_size, Color.WHITE, true)
	segment.draw_circle(Vector2.ZERO, segment.body_size, Color.BLACK, false, 2.0)
	segment.draw_line(Vector2.ZERO, Vector2(segment.body_size, 0.0), Color.BLACK, 2.0)
