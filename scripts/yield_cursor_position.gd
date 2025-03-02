extends Node2D
class_name YieldCursorPosition

signal mouse_position_changed(value: Vector2)

func _process(_delta: float) -> void:
	mouse_position_changed.emit(get_global_mouse_position())
