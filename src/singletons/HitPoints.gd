extends Node

signal on_player_zero_hitpoints()
signal on_egg_zero_hitpoints()

var player_max_hitpoints : int = 3
var player_hitpoints : int = 3
var egg_max_hitpoints : int = 3
var egg_hitpoints : int = 3


func _init() -> void:
	sync_hitpoitnts()


func sync_hitpoitnts() -> void:
	player_hitpoints = player_max_hitpoints
	egg_hitpoints = egg_max_hitpoints


func decrease_pleayer_hitpoints() -> void:
	player_hitpoints -= 1
	print("Player HP: " + String(player_hitpoints))
	
	if player_hitpoints <= 0:
		emit_signal("on_player_zero_hitpoints")


func decrease_egg_hitpoints() -> void:
	egg_hitpoints -= 1
	print("Egg HP: " + String(egg_hitpoints))
	
	if egg_hitpoints <= 0:
		emit_signal("on_egg_zero_hitpoints")
