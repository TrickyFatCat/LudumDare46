class_name Level
extends Node

signal on_load_next_level()

export(String, FILE, "*.tscn") var next_level

onready var TransitionScreen : ColorRect = $CanvasLayer/TransitionScreen
onready var LevelSwitcher : Area2D = $LevelSwitcher


func _ready() -> void:
	TransitionScreen.start_opening_transition()


func activate_close_transition() -> void:
	TransitionScreen.start_closing_transition()


func _on_TransitionScreen_on_screen_closed():
	emit_signal("on_load_next_level")
	yield(get_tree().create_timer(1.5), "timeout")
	LevelManager.load_level_by_path(next_level)


func _on_LevelSwitcher_on_trigger_atcivation():
	if Global.player.is_holding_egg or !LevelSwitcher.is_require_egg:
		activate_close_transition()
