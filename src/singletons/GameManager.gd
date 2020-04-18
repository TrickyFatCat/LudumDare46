extends StateMachine

signal on_start_game()
signal on_restart_game()
signal on_end_game()


func _ready() -> void:
	add_state("menu")
	add_state("active")
	add_state("pause")
	set_state(states.menu)


func start_game() -> void:
	emit_signal("on_start_game")
	set_state(states.active)


func restart_game() -> void:
	emit_signal("on_restart_game")
	set_state(states.active)


func end_game() -> void:
	set_state(states.menu)
	emit_signal("on_end_game")


func is_state_menu() -> bool:
	return state == states.menu


func is_state_active() -> bool:
	return state == states.active


func is_state_pause() -> bool:
	return state == states.pause
