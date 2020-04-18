class_name StateMachine
extends Node

var states = {}
var state : int = -1 setget set_state
var previous_state : int = -1


func add_state(state_name: String) -> void:
	states[state_name] = states.size()


func set_state(new_state : int) -> void:
	previous_state = state
	state = new_state
