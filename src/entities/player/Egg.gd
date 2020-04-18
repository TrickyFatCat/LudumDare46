class_name Egg
extends Entity

const MIN_DISTANCE = 128

var is_player_near : bool = false

onready var HintLabel : Label = $Hint


func _physics_process(delta) -> void:
	apply_gravity(delta)
	var collision = move_and_collide(velocity * delta)
	
	if collision != null:
		_on_impact(collision.normal, delta)


func _on_impact(normal: Vector2, delta: float):
	velocity = velocity.bounce(normal)
	velocity *= 0.5 + rand_range(-0.05, 0.05)


func launch(target_position: Vector2) -> void:
	var arc_height = target_position.y - global_position.y - MIN_DISTANCE
	arc_height = min(arc_height, -MIN_DISTANCE)
	velocity = PhysicsHelper.calculate_arc_velocity(global_position, target_position, arc_height, gravity)
	velocity = velocity.clamped(max_velocity)


# warning-ignore:unused_argument
func _input(event):
	if InputHandler.is_interact_pressed() and is_player_near:
		Global.player.set_is_holding_egg(true)
		self.queue_free()


# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	HintLabel.show()
	is_player_near = true


# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	HintLabel.hide()
	is_player_near = false
