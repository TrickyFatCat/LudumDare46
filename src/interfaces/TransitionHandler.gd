extends Node

const WAIT_TIME : float = 1.5

onready var TransitionScreen : ColorRect = $TransitionScreen


func _ready():
	TransitionScreen.start_opening_transition()


func activate_close_transition() -> void:
	TransitionScreen.start_closing_transition()


func _on_LevelChanger_body_entered(body):
	activate_close_transition()


func _on_TransitionScreen_on_screen_closed():
	pass # Replace with function body.
