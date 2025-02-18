@tool
extends Node2D
class_name Pulse

@export var radius := 30.0:
	set(value):
		radius = value
		queue_redraw()

@export var color := Color.WHITE:
	set(value):
		color = value
		queue_redraw()

func _draw() -> void:
	draw_circle(Vector2.ZERO, radius, color, false, 2.0)
