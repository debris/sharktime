extends Node
class_name TouchShark

func _on_touch_shark(creature: Creature) -> void:
	creature.speed_multiplier = 0.5
	var tween = create_tween()
	tween.tween_property(creature, "speed_multiplier", 0.2, 1.0)
