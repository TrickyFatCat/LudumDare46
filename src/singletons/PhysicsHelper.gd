extends Node


static func calculate_arc_velocity(point_a: Vector2, point_b: Vector2, arc_height: float, up_gravity: float = 1000, down_gravity: float = -1) -> Vector2:
	if down_gravity == -1:
		down_gravity = up_gravity
	
	var velocity := Vector2.ZERO
	var displacement := point_b - point_a
	
	if displacement.y > arc_height:
		var time_up = sqrt(-2 * arc_height / float(up_gravity))
		var time_down = sqrt(2 * (displacement.y - arc_height) / float(down_gravity))
		velocity.y = -sqrt(-2 * up_gravity * arc_height)
		velocity.x = displacement.x / float(time_up + time_down)
	
	return velocity
