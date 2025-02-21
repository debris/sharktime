extends Node
class_name ClearAnchor

@export var anchor: Anchor:
	set(value):
		if anchor != null:
			anchor.on_right_click.disconnect(_delete_anchor)
			anchor = null

		anchor = value

		if anchor != null:
			anchor.on_right_click.connect(_delete_anchor)

func _delete_anchor():
	anchor.queue_free()
	anchor = null
