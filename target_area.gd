@tool
extends Node2D
class_name TargetArea

@export var radius := 50.0:
	set(value):
		radius = value
		queue_redraw()
		if is_node_ready():
			_update_collision_shape()

@export var color := Color(1.0, 1.0, 1.0, 0.4):
	set(value):
		color = value
		queue_redraw()

@export var ding_sound: AudioStreamPlayer2D

@onready var collision_shape = $Area2D/CollisionShape2D

var sharks_inside := 0:
	set(value):
		sharks_inside = value
		queue_redraw()

var animated_radius := 0.0
var animation_time := 1.5

func is_shark_inside():
	return sharks_inside != 0

func _update_collision_shape():
	collision_shape.shape.radius = radius

func _ready() -> void:
	_update_collision_shape()
	# randomize animation time, it just looks better
	animation_time += randf_range(-0.2, 0.2)

func _process(delta: float) -> void:
	animated_radius += radius / animation_time * delta
	if animated_radius > radius:
		animated_radius = 0.0
	
	queue_redraw()

func _draw() -> void:
	if sharks_inside == 0:
		draw_circle(Vector2.ZERO, animated_radius, color, false, 2.0)
	else:
		draw_circle(Vector2.ZERO, radius, color, true)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CreatureHead:
		sharks_inside += 1
		if sharks_inside == 1 && ding_sound != null:
			ding_sound.play()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is CreatureHead:
		sharks_inside -= 1
