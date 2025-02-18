extends Node2D

@onready var shark: Shark = $Shark
@onready var shark2: Shark = $Shark2
@onready var shark3: Shark = $Shark3
@onready var player: Node2D = $Player

@onready var path: Path2D = $Path2D
@onready var line: Line2D = $Path2D/Line2D
@onready var goal: Node2D = $Path2D/Line2D/Goal

func _ready() -> void:
	line.clear_points()
	for point in path.curve.get_baked_points():
		line.add_point(point)

	var last = line.points[line.points.size() - 1]
	goal.position = last

func _process(_delta: float) -> void:
	shark.target_position = player.position
	shark2.target_position = player.position - shark2.position
	shark3.target_position = player.position - shark3.position

func _on_player_body_entered(body: Node2D) -> void:
	if body is CreatureHead:
		var creature = body.creature
		creature.speed_multiplier = 0.5
		var tween = create_tween()
		tween.tween_property(creature, "speed_multiplier", 0.2, 1.0)
