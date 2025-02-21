extends Node
class_name FollowCursor

@export var node: Node2D

func _process(_delta: float) -> void:
	var cursor_position = node.get_global_mouse_position()
	node.global_position = cursor_position
