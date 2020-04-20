class_name Level
extends Node

signal on_load_next_level()

export(String, FILE, "*.tscn") var next_level
export(AudioStream) var music

var is_lost : bool = false
var is_closing : bool = false
var player_start_position : Vector2
var egg_start_position : Vector2

onready var TransitionScreen : ColorRect = $CanvasLayer/TransitionScreen
onready var LevelSwitcher : Area2D = $LevelSwitcher
onready var egg_scene = preload("res://scenes/entities/player/Egg.tscn")
onready var NextLevelSound : AudioStreamPlayer = $NextLevelSound


func _ready() -> void:
	TransitionScreen.start_opening_transition()
	player_start_position = Global.player.global_position
	egg_start_position = Global.egg.global_position
# warning-ignore:return_value_discarded
	HitPoints.connect("on_player_zero_hitpoints", self, "restart_level")
# warning-ignore:return_value_discarded
	HitPoints.connect("on_egg_zero_hitpoints", self, "restart_level")
	
	if !MusicPlayer.playing:
		start_playing_music()

func activate_close_transition() -> void:
	TransitionScreen.start_closing_transition()
	Global.player.StateMachineNode.set_state_transition()


func restart_level() -> void:
	if !is_lost:
		is_lost = true
		activate_close_transition()


func start_playing_music() -> void:
	Utility.play_sound(MusicPlayer, music)


func _on_TransitionScreen_on_screen_closed():
	if is_lost:
		LevelManager.load_finish_menu()
	elif is_closing:
		get_tree().quit()
	else:
		emit_signal("on_load_next_level")
		yield(get_tree().create_timer(1.4), "timeout")
		LevelManager.load_level_by_path(next_level)


func _on_LevelSwitcher_on_trigger_atcivation():
	is_closing = false
	if Global.player.is_holding_egg or !LevelSwitcher.is_require_egg:
		activate_close_transition()
		Utility.play_sound(NextLevelSound)


func _on_TransitionScreen_on_screen_opened():
	Global.player.StateMachineNode.set_state_idle()
