@tool
extends Node2D
class_name Bezier

var points = [Vector2(100, 100), Vector2(200, 50), Vector2(300, 150), Vector2(400, 100)]:
	set(value):
		points = value
		queue_redraw()

var num_segments = 100  # Number of segments in the curve

func _ready():
	pass
	#update()  # Call update to trigger the _draw function

func _draw():
	draw_bezier_curve(points)

func draw_bezier_curve(points: Array):
	for i in range(num_segments):
		var t = i / float(num_segments)
		var bezier_point = calculate_bezier_point(points, t)
		if i > 0:
			var prev_t = (i - 1) / float(num_segments)
			var prev_point = calculate_bezier_point(points, prev_t)
			draw_line(prev_point, bezier_point, Color(1, 0, 0), 2)  # Draw the curve in red

func calculate_bezier_point(points: Array, t: float) -> Vector2:
	var n = points.size() - 1
	var point = Vector2(0, 0)
	for i in range(n + 1):
		var coefficient = binomial_coefficient(n, i) * pow(t, i) * pow(1 - t, n - i)
		point += points[i] * coefficient
	return point

func binomial_coefficient(n: int, k: int) -> int:
	if k > n:
		return 0
	if k == 0 or k == n:
		return 1
	var result = 1
	for i in range(1, k + 1):
		result = result * (n - i + 1) / i
	return result
