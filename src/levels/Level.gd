class_name Level
extends Node

signal on_load_next_level()

export(String, FILE, "*.tscn") var next_level

var is_restarting : bool = false
var player_start_position : Vector2
var egg_start_position : Vector2

onready var TransitionScreen : ColorRect = $CanvasLayer/TransitionScreen
onready var LevelSwitcher : Area2D = $LevelSwitcher
onready var egg_scene = preload("res://scenes/entities/player/Egg.tscn")


func _ready() -> void:
	TransitionScreen.start_opening_transition()
	player_start_position = Global.player.global_position
	egg_start_position = Global.egg.global_position
# warning-ignore:return_value_discarded
	HitPoints.connect("on_player_zero_hitpoints", self, "restart_level")
# warning-ignore:return_value_discarded
	HitPoints.connect("on_egg_zero_hitpoints", self, "restart_level")


func activate_close_transition() -> void:
	TransitionScreen.start_closing_transition()


func restart_level() -> void:
	is_restarting = true
	activate_close_transition()


func _on_TransitionScreen_on_screen_closed():
	if is_restarting:
		LevelManager.reload_current_level()
	else:
		emit_signal("on_load_next_level")
		yield(get_tree().create_timer(1.4), "timeout")
		LevelManager.load_level_by_path(next_level)


func _on_LevelSwitcher_on_trigger_atcivation():
	if Global.player.is_holding_egg or !LevelSwitcher.is_require_egg:
		activate_close_transition()


# warning-ignore:unused_argument
func _on_DeathTrigger_body_entered(body):
	if body is Player:
		HitPoints.decrease_pleayer_hitpoints()
		Global.player.global_position = player_start_position
		
		if body.is_holding_egg:
			body.set_is_holding_egg(false)
			HitPoints.decrease_egg_hitpoints()
			var egg_instance = egg_scene.instance()
			self.call_deferred("add_child", egg_instance)
			egg_instance.global_position = egg_start_position
		
	elif body is Egg:
		HitPoints.decrease_egg_hitpoints()
		Global.egg.global_position = egg_start_position
