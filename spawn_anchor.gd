extends Node
class_name SpawnAnchor

@export var anchors: Node2D

func _process(_delta: float) -> void:	
	if Input.is_action_just_released("left_click"):
		var anchor = preload("res://anchor.tscn").instantiate()
		anchor.global_position = anchors.get_global_mouse_position()
		var clear_anchor = ClearAnchor.new()
		clear_anchor.anchor = anchor
		anchor.add_child(clear_anchor)
		anchors.add_child(anchor)
