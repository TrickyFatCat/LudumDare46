extends Area2D

signal on_trigger_atcivation()

const NORMAL_HINT : String = "Press E"
const ERROR_HINT : String = "NO EGG"

export(bool) var is_require_egg = true
export(bool) var is_require_interaction = true

var is_player_inside : bool = false

onready var Hint : Label = $Hint


# warning-ignore:unused_argument
func _process(delta):
	if is_player_inside and InputHandler.is_interact_pressed() and !Global.player.StateMachineNode.is_dead_or_transited():
		emit_signal("on_trigger_atcivation")

	set_hint_text()


func set_hint_text() -> void:
	if is_require_egg and !is_player_holding_egg():
		Hint.text = ERROR_HINT
	else:
		Hint.text = NORMAL_HINT


# warning-ignore:unused_argument
func _on_BaseTrigger_body_entered(body):
	is_player_inside = true
	
	if is_require_interaction:
		set_hint_text()
		Hint.show()


# warning-ignore:unused_argument
func _on_BaseTrigger_body_exited(body):
	is_player_inside = false
	
	if is_require_interaction:
		set_hint_text()
		Hint.hide()


func is_player_holding_egg() -> bool:
	return Global.player.is_holding_egg
