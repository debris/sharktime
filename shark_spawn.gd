extends Node2D
class_name SharkSpawn

signal spawned(shark: Shark)

@export var period:= 5.0
@export var autospawn := true

@onready var path_follow: PathFollow2D = $Path2D/PathFollow2D

var time_left = period

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time_left -= delta

	if autospawn && time_left < 0.0:
		spawn_shark()
		time_left = period

func spawn_shark():
	path_follow.progress_ratio = randf_range(0.0, 1.0)
	var shark = preload("res://shark.tscn").instantiate()
	shark.global_position = path_follow.global_position
	spawned.emit(shark)
