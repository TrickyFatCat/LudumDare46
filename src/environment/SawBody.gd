tool
extends Area2D

export(bool) var is_moving = true
export(bool) var is_linear_movement = false
export(float) var travel_time = 1.0
export(float) var wait_time = 1.0
export(bool) var is_cycled = true
export(bool) var one_way = false

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
	var tween_type
	
	if is_linear_movement:
		tween_type = Tween.TRANS_LINEAR
	else:
		tween_type = Tween.TRANS_QUINT
	
	TweenNode.interpolate_property(self, "position", global_position, target_position, travel_time, tween_type, Tween.EASE_IN_OUT)
	TweenNode.start()


func activate_saw_movement() -> void:
	set_target_point()
	
	if next_point_index != target_points.size():
		start_tween(target_point.global_position)
		next_point_index += 1
	


func set_target_point()-> void:
	if next_point_index == target_points.size() and !one_way:
		if !is_cycled:
			target_points.invert()
			next_point_index = 1
		else:
			next_point_index = 0
		
		target_point = target_points[next_point_index]
	else:
		target_point = target_points[next_point_index]
	pass


func _on_SawBody_body_entered(body):
	if !HitPoints.is_low_hitpoints():
		if body is Player:
			HitPoints.decrease_pleayer_hitpoints()
		if body is Egg:
			HitPoints.decrease_egg_hitpoints()


func _on_Tween_tween_all_completed():
	WaitTimer.start()


func _on_WaitTimer_timeout():
	activate_saw_movement()
