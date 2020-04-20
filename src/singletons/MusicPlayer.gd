extends AudioStreamPlayer

var level_music : AudioStream
var menu_music : AudioStream
var game_over_music : AudioStream = load("res://sounds/music/gameOver.ogg")

func _ready() -> void:
	volume_db = -12
# warning-ignore:return_value_discarded
	HitPoints.connect("on_egg_zero_hitpoints", self, "play_gameover_music")
# warning-ignore:return_value_discarded
	HitPoints.connect("on_player_zero_hitpoints", self, "play_gameover_music")


func play_gameover_music() -> void:
	if stream != game_over_music:
		Utility.play_sound(self, game_over_music)
