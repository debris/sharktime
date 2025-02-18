@tool
extends Node2D
class_name CatmullRomShape

@export var points: PackedVector2Array:
	set(value):
		points = value
		queue_redraw()

@export var border_color: Color = Color.BLACK:
	set(value):
		border_color = value
		queue_redraw()

@export var fill_color: Color = Color.RED:
	set(value):
		fill_color = value
		queue_redraw()

@export_range(1, 100) var smoothness: int = 20:
	set(value):
		smoothness = value
		queue_redraw()

# Called when the node is added to the scene.
func _ready():
	queue_redraw()

# The _draw() function where drawing takes place.
func _draw():
	# Get smooth curve vertices.
	var vertices = get_curve_vertices()
	
	if vertices.is_empty():
		return

	# Draw a filled polygon with color.
	draw_polygon(vertices, [fill_color])
	#draw_polygon(vertices, [fill_color], [], preload("res://bar.png"))

	# Optionally, draw an outline for clarity.
	# We add the first vertex at the end to close the loop visually.
	draw_polyline(vertices + [vertices[0]], border_color, 2)

# Generates a list of vertices along the Catmull-Rom spline.
# If 'closed' is true, the spline will wrap around to form a closed shape.
func get_curve_vertices() -> Array:
	var steps = smoothness
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
