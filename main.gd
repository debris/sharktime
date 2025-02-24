extends Control

signal goto_main_menu
signal goto_game
signal goto_score(score: String)

@onready var root = $CanvasLayer/Root


func _ready() -> void:
	goto_main_menu.connect(display_main_menu)
	goto_game.connect(display_game)
	goto_score.connect(display_score)
	display_main_menu()

func clear_root():
	for child in root.get_children():
		child.queue_free()

func display_main_menu():
	clear_root()

	var main_menu = preload("res://main_menu.tscn").instantiate()
	root.add_child(main_menu)

	main_menu.quit_pressed.connect(func():
		get_tree().quit()
	)
	
	await main_menu.start_pressed
	goto_game.emit()


func display_game():
	clear_root()

	var game = preload("res://game.tscn").instantiate()
	root.add_child(game)

	game.restart_pressed.connect(func():
		goto_game.emit()
	)

	game.back_pressed.connect(func():
		goto_main_menu.emit()
	)

	game.game_completed.connect(func(score_text):
		goto_score.emit(score_text)
	)

func display_score(s: String):
	clear_root()

	var score = preload("res://score.tscn").instantiate()
	score.score = s
	root.add_child(score)

	await score.replay_pressed
	goto_game.emit()
