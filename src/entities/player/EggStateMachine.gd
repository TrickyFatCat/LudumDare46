extends StateMachine


enum INITIAL_STATE{
	TOGETHER,
	ALONE,
	INACTIVE
}

export(INITIAL_STATE) var initial_state = INITIAL_STATE.TOGETHER


func _ready():
	add_state("alone")
	add_state("together")
	add_state("inactive")
	set_initial_state()


func set_initial_state() -> void:
	match initial_state:
		INITIAL_STATE.TOGETHER:
			set_state(states.together)
		INITIAL_STATE.ALONE:
			set_state(states.alone)
		INITIAL_STATE.INACTIVE:
			set_state(states.inactive)
