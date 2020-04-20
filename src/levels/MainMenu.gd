extends Level


func _on_ExitGame_on_trigger_atcivation():
	is_closing = true
	activate_close_transition()
