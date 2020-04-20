class_name Egg
extends Entity

const MIN_DISTANCE = 256
const DAMAGE_THROW_DISTANCE = 512
const DAMAGE_THROW_VELOCITY = 500

onready var Trigger : Area2D = $BaseTrigger


func _ready() -> void:
	Global.egg = self
# warning-ignore:return_value_discarded
	HitPoints.connect("on_egg_take_damage", self, "on_damage_taken")


func _physics_process(delta) -> void:
	apply_gravity(delta)
	var collision = move_and_collide(velocity * delta)

	
	if collision != null:
		_on_impact(collision.normal, delta)


# warning-ignore:unused_argument
func _on_impact(normal: Vector2, delta: float):
	velocity = velocity.bounce(normal)
	velocity *= 0.3 + rand_range(-0.05, 0.05)


func launch(target_position: Vector2, throw_velocity: float = max_velocity) -> void:
	var initial_position = global_position
	var arc_height = target_position.y - initial_position.y - MIN_DISTANCE
	arc_height = min(arc_height, -MIN_DISTANCE)
	velocity = PhysicsHelper.calculate_arc_velocity(initial_position, target_position, arc_height, gravity)
	velocity = velocity.clamped(throw_velocity)


func set_global_position(new_position: Vector2) -> void:
	global_position = new_position


func on_damage_taken() -> void:
	activate_godmode()
	var direction_x = Utility.choosei([-1, 1])
	
	var target_point = global_position + Vector2(DAMAGE_THROW_DISTANCE * direction_x, global_position.y)
	launch(target_point, DAMAGE_THROW_VELOCITY)


func _on_BaseTrigger_on_trigger_atcivation():
	Global.player.set_is_holding_egg(true)
	set_physics_process(false)
	self.queue_free()
