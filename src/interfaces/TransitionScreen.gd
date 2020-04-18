extends ColorRect

signal on_screen_opened()
signal on_screen_closed()
signal on_screen_start_opening()
signal on_screen_start_closing()


enum start_state{
	CLOSED,
	OPENED
}

const TRANSITION_DURATION : float = 50.0
const MIN_CUTOFF : float = 0.0
const MAX_CUTOFF : float = 1.0

export(start_state) var initial_state = start_state.CLOSED

var cutoff : float
var transition_material : ShaderMaterial

onready var StateMachineNode : StateMachine = $StateMachine
onready var TransitionTween : Tween = $TransitionTween


func _ready() -> void:
	transition_material = self.get_material()
	set_initial_state()


func _process(delta) -> void:
	set_cutoff()


func set_initial_state() -> void:
	match initial_state:
		start_state.CLOSED:
			StateMachineNode.set_state_closed()
			cutoff = MIN_CUTOFF
			set_cutoff()
		start_state.OPENED:
			StateMachineNode.set_state_opened()
			cutoff = MAX_CUTOFF
			set_cutoff()


func set_cutoff() -> void:
	clamp(cutoff, MIN_CUTOFF, MAX_CUTOFF)
	transition_material.set_shader_param("cutoff", cutoff)


func start_opening_transition() -> void:
	StateMachineNode.set_state_opening()
	emit_signal("on_screen_start_opening")
	activate_tween(MIN_CUTOFF, MAX_CUTOFF)


func start_closing_transition() -> void:
	StateMachineNode.set_state_closing()
	emit_signal("on_screen_start_closing")
	activate_tween(MAX_CUTOFF, MIN_CUTOFF)


func activate_tween(initial_value: float, target_value: float) -> void:
	TransitionTween.interpolate_property(self, "cutoff", initial_value, target_value, TRANSITION_DURATION, Tween.TRANS_LINEAR, Tween.EASE_IN)
	TransitionTween.start()


func _on_TransitionTween_tween_all_completed():
	if StateMachineNode.is_previous_state_opening():
			StateMachineNode.set_state_opened()
			emit_signal("on_screen_opened")
	elif StateMachineNode.is_previous_state_closing():
			StateMachineNode.set_state_closed()
			emit_signal("on_screen_closed")
