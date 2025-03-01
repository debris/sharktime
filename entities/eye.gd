@tool
extends Node2D
class_name Eye

func _draw() -> void:
	draw_circle(Vector2.ZERO, 5.0, Color.WHITE, true)

