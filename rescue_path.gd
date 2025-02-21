@tool
extends Node2D
class_name RescuePath

signal highlight_path(path: PackedVector2Array)

@export var curve: Curve2D:
	set(value):
		curve = value
		if is_node_ready():
			_update_path()

@onready var path: Path2D = $Path2D

func _update_path():
	path.curve = curve

func _ready() -> void:
	_update_path()

func _on_drowning_person_hovered() -> void:
	var points = PackedVector2Array()
	for point in path.curve.get_baked_points():
		points.append(point + path.global_position)

	highlight_path.emit(points)
