extends Area2D
class_name AnchorScanner

signal closest_anchor_updated(anchor: Vector2)

@export var body: Body

var anchors := {}
var closest_anchor := Vector2.ZERO

func get_closest_anchor() -> Vector2:
	return closest_anchor

func _update_closest_anchor() -> Vector2:
	# if there are no anchors, return old target_position
	if anchors.size() == 0:
		return closest_anchor

	var closest = null
	var head = body.get_segments()[0]
	for anchor in anchors.keys():
		if closest == null || head.global_position.distance_to(anchor.global_position) < head.global_position.distance_to(closest):
			closest = anchor.global_position

	return closest

func _ready() -> void:
	area_entered.connect(_on_anchor_scanner_area_entered)
	area_exited.connect(_on_anchor_scanner_area_exited)

func _process(_delta: float) -> void:
	closest_anchor = _update_closest_anchor() - body.global_position
	closest_anchor_updated.emit(closest_anchor)

func _on_anchor_scanner_area_entered(anchor: Area2D) -> void:
	anchors[anchor] = null

func _on_anchor_scanner_area_exited(anchor: Area2D) -> void:
	anchors.erase(anchor)
