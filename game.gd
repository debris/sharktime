extends Node2D

signal back_pressed
signal restart_pressed

@onready var sharks: Node2D = $Sharks
@onready var targets: Node2D = $Targets
@onready var score_label: Label = $CanvasLayer/Control/ScoreLabel
@onready var time_label: Label = $CanvasLayer/Control/TimeLabel

var time := 0.0
var current_target_index := 0
var score := 0:
	set(value):
		score = value
		if is_node_ready():
			_update_score_label()

func _update_score_label():
	score_label.text = str(score)

func _ready() -> void:
	clear_targets()
	add_targets()
	_update_score_label()

func add_targets():
	var new_targets = TargetLoader.get_targets()[current_target_index]
	current_target_index += 1

	var width = 1152.0 * 2.0
	var height = 648.0 * 2.0

	for t in new_targets:
		var target_area = preload("res://target_area.tscn").instantiate()
		target_area.radius = 200.0
		target_area.position = Vector2(width, height) * t
		targets.add_child(target_area)

func clear_targets():
	for target in targets.get_children():
		target.queue_free()

func are_sharks_in_targets() -> bool:
	for target in targets.get_children():
		if !target.is_shark_inside():
			return false
	return true

func _process(delta: float) -> void:
	time += delta

	@warning_ignore("integer_division")
	time_label.text = "%d:%02d" % [int(time) / 60, int(time) % 60]

	if are_sharks_in_targets():
		score += targets.get_child_count() * 50
		clear_targets()
		add_targets()

func _on_shark_spawn_spawned(new_shark: Shark) -> void:
	sharks.add_child(new_shark)

func _on_back_button_pressed() -> void:
	back_pressed.emit()

func _on_restart_button_pressed() -> void:
	restart_pressed.emit()
