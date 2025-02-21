extends Node
class_name TargetLoader

static var targets = [
	[Vector2(0.5, 0.5)],
	[Vector2(0.5, 0.2), Vector2(0.5, 0.8)],
	[Vector2(0.25, 0.5), Vector2(0.5, 0.5), Vector2(0.75, 0.5)],
	[Vector2(0.25, 0.25), Vector2(0.5, 0.5), Vector2(0.75, 0.75)]
]

static func get_targets():
	return targets
