extends ColorRect

signal on_screen_opened()
signal on_screen_closed()
signal on_screen_start_opening()
signal on_screen_start_closing()


enum start_state{
	CLOSED,
	OPENED
}

const TRANSITION_DURATION : float = 0.75
const MIN_CUTOFF : float = 0.0
const MAX_CUTOFF : float = 1.0

export(start_state) var initial_state = start_state.CLOSED

var transition_material : ShaderMaterial

onready var StateMachineNode : StateMachine = $StateMachine
onready var TransitionTween : Tween = $TransitionTween


func _ready() -> void:
	self.show()
	transition_material = self.material
	set_initial_state()


func set_initial_state() -> void:
	match initial_state:
		start_state.CLOSED:
			StateMachineNode.set_state_closed()
			set_cutoff(MIN_CUTOFF)
		start_state.OPENED:
			StateMachineNode.set_state_opened()
			set_cutoff(MAX_CUTOFF)


func set_cutoff(value: float) -> void:
	value = clamp(value, MIN_CUTOFF, MAX_CUTOFF)
	transition_material.set_shader_param("cutoff", value)


func start_opening_transition() -> void:
	StateMachineNode.set_state_opening()
	emit_signal("on_screen_start_opening")
	activate_tween(MIN_CUTOFF, MAX_CUTOFF)


func start_closing_transition() -> void:
	StateMachineNode.set_state_closing()
	emit_signal("on_screen_start_closing")
	activate_tween(MAX_CUTOFF, MIN_CUTOFF)


func activate_tween(initial_value: float, target_value: float) -> void:
# warning-ignore:return_value_discarded
	TransitionTween.interpolate_method(self, "set_cutoff", initial_value, target_value, TRANSITION_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
# warning-ignore:return_value_discarded
	TransitionTween.start()


func is_transition_active() -> bool:
	return TransitionTween.is_active()


func _on_TransitionTween_tween_all_completed():
	if StateMachineNode.is_previous_state_opening():
			StateMachineNode.set_state_opened()
			emit_signal("on_screen_opened")
	elif StateMachineNode.is_previous_state_closing():
			StateMachineNode.set_state_closed()
			emit_signal("on_screen_closed")
