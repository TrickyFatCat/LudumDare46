tool
extends KinematicBody2D

export(bool) var is_moving = true
export(float) var travel_time = 1.0
export(float) var wait_time = 1.0
export(bool) var is_cycled = true

var next_point_index : int = 0
var target_point : Node2D

onready var WaitTimer = $WaitTimer
onready var TweenNode = $Tween
onready var target_points = $TargetPoints.get_children()

func _ready():
	WaitTimer.wait_time = wait_time
	
	if is_moving:
		activate_saw_movement()


func start_tween(target_position: Vector2) -> void:
	TweenNode.interpolate_property(self, "position", global_position, target_position, travel_time, Tween.TRANS_QUINT, Tween.EASE_IN_OUT)
	TweenNode.start()


func activate_saw_movement() -> void:
	set_target_point()
	start_tween(target_point.global_position)
	next_point_index += 1


func set_target_point()-> void:
	if next_point_index == target_points.size():
		if !is_cycled:
			target_points.invert()
			next_point_index = 1
		else:
			next_point_index = 0
		
		target_point = target_points[next_point_index]
	else:
		target_point = target_points[next_point_index]
	pass



func _on_Tween_tween_all_completed():
	WaitTimer.start()


func _on_WaitTimer_timeout():
	activate_saw_movement()
