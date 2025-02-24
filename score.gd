extends Control
class_name Score

signal replay_pressed

@export var score: String:
	set(value):
		score = value
		if is_node_ready():
			_update_score_label()

@onready var score_label: Label = $ScoreLabel

func _update_score_label():
	score_label.text = score

func _ready() -> void:
	_update_score_label()

func _on_replay_button_pressed() -> void:
	replay_pressed.emit()
