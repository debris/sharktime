extends Node2D
class_name Anchor

signal on_right_click
signal on_touch_shark(creature: Creature)

@onready var ball = $Ball

var time = 0.0

func _process(delta: float) -> void:
	time += delta
	ball.position.y = 30.0 * sin(time)

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_released("right_click"):
		on_right_click.emit()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CreatureHead:
		on_touch_shark.emit(body.creature)
