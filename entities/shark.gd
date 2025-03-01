@tool
extends Node2D
class_name Shark

@export var target_position: Vector2

@onready var creature: Creature = $Creature
@onready var catmull_rom_shape: CatmullRomShape = $CatmullRomShape
@onready var top_fin: CatmullRomShape = $TopFin

var anchors = {}

func _get_closest_anchor() -> Vector2:
	# if there are no anchors, return old target_position
	if anchors.size() == 0:
		return target_position

	var closest = null
	var head = creature.get_segments()[0]
	for anchor in anchors.keys():
		if closest == null || head.global_position.distance_to(anchor.global_position) < head.global_position.distance_to(closest):
			closest = anchor.global_position

	return closest

func _process(_delta: float) -> void:
	target_position = _get_closest_anchor()
	creature.target_position = target_position - position

	var segments = creature.get_segments()
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

	catmull_rom_shape.points = right_points

	top_fin.points = [segments[1].position, segments[2].position, segments[3].position, segments[4].position]


func _on_anchor_scanner_area_entered(area: Area2D) -> void:
	anchors[area] = null

func _on_anchor_scanner_area_exited(area: Area2D) -> void:
	anchors.erase(area)
