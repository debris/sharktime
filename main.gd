extends Control

signal needs_update

enum State {
	MAIN_MENU,
	GAME,
}

@onready var root = $CanvasLayer/Root

var state = State.MAIN_MENU

func _ready() -> void:
	needs_update.connect(_on_update)
	_on_update()	

func _on_update():
	match state:
		State.MAIN_MENU:
			display_main_menu()
		State.GAME:
			display_game()

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
	state = State.GAME
	needs_update.emit()


func display_game():
	clear_root()

	var game = preload("res://game.tscn").instantiate()
	root.add_child(game)

	game.restart_pressed.connect(func():
		state = State.GAME
		needs_update.emit()
	)

	game.back_pressed.connect(func():
		state = State.MAIN_MENU
		needs_update.emit()
	)
