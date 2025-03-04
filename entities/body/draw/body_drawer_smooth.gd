@tool
extends BodyDrawer
class_name BodyDrawerSmooth

@export var fill_color: Color = Color.BLACK
@export var border_color: Color = Color.WHITE

func _draw_body(body: Body):
	var segments = body.get_segments()
	var left_points = []
	var right_points = []

	# draw head
	var head = segments[0]
	var angle45 = deg_to_rad(45.0)
	var middle = head.position + Vector2(head.body_size, 0.0).rotated(head.rotation)
	var middle_left = head.position + Vector2(head.body_size, 0.0).rotated(head.rotation - angle45)
	var middle_right = head.position + Vector2(head.body_size, 0.0).rotated(head.rotation + angle45)
	left_points.push_back(middle)
	left_points.push_back(middle_left)
	right_points.push_back(middle_right)

	# continue the stroke on both sides
	for i in segments.size():
		var current = segments[i]
		var angle = deg_to_rad(90.0)

		var left_front = current.position + Vector2(current.body_size, 0.0).rotated(current.rotation - angle)
		var right_front = current.position + Vector2(current.body_size, 0.0).rotated(current.rotation + angle)

		left_points.push_back(left_front)
		right_points.push_back(right_front)

	right_points.reverse()
	right_points.append_array(left_points)

	var vertices = get_curve_vertices(right_points)
	
	if vertices.is_empty():
		return

	body.draw_polygon(vertices, [fill_color])
	body.draw_polyline(vertices + [vertices[0]], border_color, 2.0)


func _draw_segment(_segment: Segment):
	pass


# Generates a list of vertices along the Catmull-Rom spline.
# If 'closed' is true, the spline will wrap around to form a closed shape.
func get_curve_vertices(points: PackedVector2Array, steps: int = 20) -> Array:
	var vertices = []
	var n = points.size()
	if n < 2:
		return vertices  # Not enough points to form a curve.
	
	# For a closed shape, wrap indices modulo n.
	# For each segment between points[i] and points[i+1]:
	for i in range(n):
		# Get the four control points for this segment.
		var p0 = points[(i - 1 + n) % n]
		var p1 = points[i]
		var p2 = points[(i + 1) % n]
		var p3 = points[(i + 2) % n]
		
		# Interpolate between p1 and p2.
		for j in range(steps):
			var t = j / float(steps)
			var pt = catmull_rom(p0, p1, p2, p3, t)
			vertices.append(pt)
	return vertices

# Implements the Catmull-Rom spline interpolation formula.
# Given four control points (p0, p1, p2, p3) and a parameter t in [0, 1],
# this returns an interpolated point between p1 and p2.
func catmull_rom(p0: Vector2, p1: Vector2, p2: Vector2, p3: Vector2, t: float) -> Vector2:
	var t2 = t * t
	var t3 = t2 * t
	var x = 0.5 * ((2 * p1.x) +
		(-p0.x + p2.x) * t +
		(2 * p0.x - 5 * p1.x + 4 * p2.x - p3.x) * t2 +
		(-p0.x + 3 * p1.x - 3 * p2.x + p3.x) * t3)
	var y = 0.5 * ((2 * p1.y) +
		(-p0.y + p2.y) * t +
		(2 * p0.y - 5 * p1.y + 4 * p2.y - p3.y) * t2 +
		(-p0.y + 3 * p1.y - 3 * p2.y + p3.y) * t3)
	return Vector2(x, y)
