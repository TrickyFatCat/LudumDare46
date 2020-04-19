extends Level


func _on_ExitGame_on_trigger_atcivation():
	get_tree().quit()


func _on_FinishMenu_on_load_next_level():
	PointsHandler.reset_points()
