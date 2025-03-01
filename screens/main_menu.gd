extends Control

signal start_pressed
signal quit_pressed

func _on_start_button_pressed() -> void:
	start_pressed.emit()

func _on_quit_button_pressed() -> void:
	quit_pressed.emit()
