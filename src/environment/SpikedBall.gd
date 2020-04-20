extends Area2D

func _on_SpikedBall_body_entered(body):
	if !HitPoints.is_low_hitpoints():
		if body is Player:
			HitPoints.decrease_pleayer_hitpoints()
		if body is Egg:
			HitPoints.decrease_egg_hitpoints()
