extends Node

signal on_taking_damage()
signal on_critical_hitpoints()

var max_hitpoints : int = 1
var hitpoints : int = 1


func set_hitpoints(value: int) -> void:
	max_hitpoints = value
	hitpoints = value


func decrease_hitpoints(damage: int) -> void:
	hitpoints -= damage
	
	if hitpoints <= 0:
		emit_signal("on_critical_hitpoints")
	else:
		emit_signal("on_taking_damage")
