extends StateMachine

func _ready():
	add_state("closed")
	add_state("opening")
	add_state("opened")
	add_state("closing")


func set_state_closed() -> void:
	set_state(states.closed)


func set_state_opened() -> void:
	set_state(states.opened)


func set_state_opening() -> void:
	set_state(states.opening)


func set_state_closing() -> void:
	set_state(states.closing)


func is_previous_state_closing() -> bool:
	return state == states.closing


func is_previous_state_opening() -> bool:
	return state == states.opening
