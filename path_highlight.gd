extends Node2D
class_name PathHighlight

@export var points: PackedVector2Array: set = _set_points

@onready var line: Line2D = $Line2D
@onready var goal: Node2D = $Goal

func _set_points(value: PackedVector2Array):
		points = value
		if is_node_ready():
			_update_line()

func _update_line():
	if !points || points.is_empty():
		line.clear_points()
		return

	line.points = points
	var last = line.points[line.points.size() - 1]
	goal.position = last

func _ready() -> void:
	_update_line()
