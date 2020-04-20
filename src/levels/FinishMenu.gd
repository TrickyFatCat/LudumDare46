extends Level


func _ready() -> void:
	MusicPlayer.connect("finished", self, "start_playing_music")


func _on_ExitGame_on_trigger_atcivation():
	is_closing = true
	activate_close_transition()


func _on_FinishMenu_on_load_next_level():
	PointsHandler.reset_points()
