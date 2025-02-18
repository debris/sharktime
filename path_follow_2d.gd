extends PathFollow2D

@export var line: Line2D

var speed = 50.0
var forward = false

func _ready() -> void:
	line.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if forward:
		progress += speed * delta
	else:
		progress = max(0.0, progress - speed * delta)


func _on_area_2d_mouse_entered() -> void:
	forward = true
	line.visible = true
	print_debug("entered")

func _on_area_2d_mouse_exited() -> void:
	forward = false
	line.visible = false
	print_debug("exited")
