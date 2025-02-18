@tool
extends Node2D

const DISTANCE_CONSTRAINT = 50.0

class Point:
	var position: Vector2
	var distance_constraint: float
	var body_size: float

@export var curve: Curve 

var bezier_a = Bezier.new()
var bezier_b = Bezier.new()

var points: Array

func _ready() -> void:
	for i in [52.0, 58.0, 40.0, 60.0, 68.0, 71.0, 65.0, 50.0, 28.0, 15.0, 11.0, 9.0, 7.0, 7.0, 30.0]:
		var next_point = Point.new()
		next_point.distance_constraint = DISTANCE_CONSTRAINT / 2.0
		next_point.body_size = i / 2.0
		points.push_back(next_point)

	add_child(bezier_a)
	add_child(bezier_b)

func update_tail():
	var i = 0
	while i + 1 < points.size():
		var prev_point = points[i]
		var point = points[i + 1]
		var direction = point.position.direction_to(prev_point.position)
		point.position = prev_point.position - direction * prev_point.distance_constraint
		i += 1

func _process(delta: float) -> void:
	var mouse_position = get_global_mouse_position()
	var target_position = mouse_position

	var distance = points[0].position.distance_to(target_position)
	var speed = curve.sample(distance / 1000.0)
	points[0].position = points[0].position.move_toward(target_position, delta * 1000.0 * speed)

	queue_redraw()

# return head angle in degrees
func head_angle() -> float:
	var prev_point = points[0]
	var point = points[1]
	return rad_to_deg(point.position.angle_to_point(prev_point.position))

func _draw() -> void:
	update_tail()

	# draw circles
	for point in points:
		draw_circle(point.position, point.body_size, Color.WHITE, false)
	
	var side_a_points = []
	var side_b_points = []

	# draw head point
	if true:
		var prev_point = points[0]
		var point = points[1]
		var direction = point.position.direction_to(prev_point.position)
		var head = prev_point.position + direction * prev_point.body_size
		#draw_circle(head, 5.0, Color.RED, true)
		side_a_points.push_back(head)
		side_b_points.push_back(head)


	# draw points on the side of the circle
	for i in points.size() - 1:
		var prev_point = points[i]
		var point = points[i + 1]
		var direction = point.position.direction_to(prev_point.position)

		var angle = deg_to_rad(90.0)

		var side_a = point.position + direction.rotated(angle) * point.body_size
		#draw_circle(side_a, 5.0, Color.RED, true)
		side_a_points.push_back(side_a)

		var side_b = point.position + direction.rotated(-angle) * point.body_size
		#draw_circle(side_b, 5.0, Color.RED, true)
		side_b_points.push_back(side_b)

	#side_b_points.reverse()
	#side_a_points.append_array(side_b_points)

	bezier_a.points = side_a_points
	#bezier_b.points = []
	bezier_b.points = side_b_points

	# connect lines
	#for i in points.size() - 1:
		#draw_line(points[i].position, points[i + 1].position, Color.WHITE, 2.0)
