extends Node2D
class_name Notification

@onready var label: Label = $Label

var speed = 100.0

func _process(delta: float) -> void:
	label.position.y -= speed * delta
	label.modulate.a -= delta

	if label.modulate.a < 0.0:
		queue_free()
