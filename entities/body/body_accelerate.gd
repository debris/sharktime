extends Node
class_name BodyAccelerate

func accelerate(body: Body) -> void:
	body.speed_multiplier = 0.5
	var tween = create_tween()
	tween.tween_property(body, "speed_multiplier", 0.2, 1.0)
