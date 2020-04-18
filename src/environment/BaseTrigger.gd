extends Area2D

signal on_trigger_atcivation()

const NORMAL_HINT : String = "Press F"
const ERROR_HINT : String = "Bring the egg"

export(bool) var is_require_egg = true

var is_player_inside : bool = false

onready var Hint : Label = $Hint


func _process(delta):
	if is_player_inside and InputHandler.is_interact_pressed():
		emit_signal("on_trigger_atcivation")


func set_hint_text() -> void:
	if is_require_egg and !Global.player.is_holding_egg:
		Hint.text = ERROR_HINT
	else:
		Hint.text = NORMAL_HINT


func _on_BaseTrigger_body_entered(body):
	is_player_inside = true
	set_hint_text()
	Hint.show()


func _on_BaseTrigger_body_exited(body):
	is_player_inside = false
	set_hint_text()
	Hint.hide()
