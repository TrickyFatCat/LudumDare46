extends Level


func _on_FinishMenu_on_load_next_level():
	print_debug("Restart game needs logic")


func _on_ExitGame_on_trigger_atcivation():
	get_tree().quit()
