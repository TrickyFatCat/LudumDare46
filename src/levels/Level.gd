class_name Level
extends Node

signal on_load_next_level()

export(String, FILE, "*.tscn") var next_level

onready var TransitionScreen : ColorRect = $CanvasLayer/TransitionScreen


func _ready() -> void:
	TransitionScreen.start_opening_transition()


func activate_close_transition() -> void:
	TransitionScreen.start_closing_transition()


func _on_TransitionScreen_on_screen_closed():
	emit_signal("on_load_next_level")
	yield(get_tree().create_timer(1.5), "timeout")
	LevelManager.load_level_by_path(next_level)
	Global.player == null


# warning-ignore:unused_argument
func _on_LevelSwitcher_body_entered(body):
	if body.is_holding_egg:
		activate_close_transition()
