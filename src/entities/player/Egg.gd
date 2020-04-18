class_name Egg
extends Entity

const MIN_DISTANCE = 120


func _physics_process(delta) -> void:
	apply_gravity(delta)
	var collision = move_and_collide(velocity * delta)
	
	if collision != null:
		_on_impact(collision.normal, delta)


# warning-ignore:unused_argument
func _on_impact(normal: Vector2, delta: float):
	velocity = velocity.bounce(normal)
	velocity *= 0.4 + rand_range(-0.05, 0.05)


func launch(target_position: Vector2) -> void:
	var arc_height = target_position.y - global_position.y - MIN_DISTANCE
	arc_height = min(arc_height, -MIN_DISTANCE)
	velocity = PhysicsHelper.calculate_arc_velocity(global_position, target_position, arc_height, gravity)
	velocity = velocity.clamped(max_velocity)


func _on_BaseTrigger_on_trigger_atcivation():
	Global.player.set_is_holding_egg(true)
	self.queue_free()
