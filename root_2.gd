extends Node2D

@onready var shark: Shark = $Shark
@onready var shark2: Shark = $Shark2
@onready var shark3: Shark = $Shark3
@onready var player: Node2D = $Player

@onready var sharks: Node2D = $Sharks
@onready var targets: Node2D = $Targets
@onready var score_label: Label = $CanvasLayer/Control/ScoreLabel

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

func _process(_delta: float) -> void:
	#shark.target_position = player.position
	#shark2.target_position = player.position - shark2.position
	#shark3.target_position = player.position - shark3.position

	#for s in sharks.get_children():
	#	s.target_position = player.position - s.position

	if are_sharks_in_targets():
		score += targets.get_child_count() * 50
		clear_targets()
		add_targets()

func _on_player_body_entered(body: Node2D) -> void:
	if body is CreatureHead:
		var creature = body.creature
		creature.speed_multiplier = 0.5
		var tween = create_tween()
		tween.tween_property(creature, "speed_multiplier", 0.2, 1.0)

func _on_shark_spawn_spawned(new_shark: Shark) -> void:
	sharks.add_child(new_shark)
