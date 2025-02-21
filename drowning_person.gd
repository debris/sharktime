extends PathFollow2D
class_name DrowningPerson

signal hovered

@export var min_speed := -25.0
@export var max_speed := 75.0
# deceleration per second
@export var deceleration := 25.0
# acceleration per click
@export var acceleration := 25.0

var speed = 0.0

func _process(delta: float) -> void:
	# let's not move below 0.0 progress
	progress = max(0.0, progress + speed * delta)

	# decelerate over time
	speed = max(min_speed, speed - deceleration * delta)

func _on_area_2d_mouse_entered() -> void:
	hovered.emit()

func _on_area_2d_mouse_exited() -> void:
	pass

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		# at least 25.0, at most 75.0
		speed = min(max_speed, max(acceleration, speed + acceleration))
