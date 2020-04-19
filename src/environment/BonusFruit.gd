extends Area2D

export(int) var points_cost = 1


# warning-ignore:unused_argument
func _on_BonusFruit_body_entered(body):
	PointsHandler.increase_points(points_cost)
	queue_free()
