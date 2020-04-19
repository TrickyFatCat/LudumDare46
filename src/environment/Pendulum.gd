tool
extends Node2D

export(float) var fluctuation_time = 1.0
export(float) var min_angle = 45.0
export(float) var max_angle = -45.0

onready var TweenNode : Tween = $Tween 


func _ready() -> void:
	start_fluctuation(min_angle, max_angle)


func start_fluctuation(initial_rotation: float, target_rotation: float) -> void:
# warning-ignore:return_value_discarded
	TweenNode.interpolate_property(self, "rotation_degrees", initial_rotation, target_rotation, fluctuation_time, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
# warning-ignore:return_value_discarded
	TweenNode.start()


func _on_Tween_tween_all_completed():
	if rotation_degrees == min_angle:
		start_fluctuation(min_angle, max_angle)
	else:
		start_fluctuation(max_angle, min_angle)
	
