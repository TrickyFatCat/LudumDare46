class_name Player
extends Entity

signal on_taking_egg()
signal on_throw_egg()
signal on_jump()
signal on_move()

const JUMP_VELOCITY : float = 450.0
const JUMP_GRAVITY : float = 1750.0
const JMUP_BONUS_VELOCITY : float = 100.0
const STUNLOCK_VELOCITY : float = 350.0
const STUNLOCK_JUMP_VELOCITY : float = 450.0
const GROUND_ACCELERATION : float = 5000.0
const AIR_ACCELERATION : float = 7000.0
const THROW_TARGET : Vector2 = Vector2(512, 256)
const THROW_VELOCITY : float = 750.0
const STUNLOCK_THROW_VELOCITY : float = 500.0

var is_holding_egg : bool = false
var facing_direction : int = 1

onready var EggSprite : Sprite = $EggSprite
onready var egg_scene : PackedScene = preload("res://scenes/entities/player/Egg.tscn")


func _ready() -> void:
	Global.player = self


# warning-ignore:unused_argument
func _input(event):
	if InputHandler.is_shoot_pressed() and is_holding_egg and !StateMachineNode.is_dead_or_transited():
		throw_egg(THROW_VELOCITY)


func calculate_direction_x() -> void:
	direction.x = InputHandler.get_move_right_strength() - InputHandler.get_move_left_strength()


func calculate_velocity_x(delta: float, direction: Vector2) -> void:
	if direction.x != 0 and abs(velocity.x) <= max_velocity:
		velocity.x += acceleration * direction.x * delta
		velocity.x = clamp(velocity.x, -max_velocity, max_velocity)
		emit_signal("on_move")
	elif velocity.x != 0 or abs(velocity.x) > max_velocity:
		direction.x = -sign(velocity.x)
		velocity.x += friction * direction.x * delta
		
		if direction.x < 0:
			velocity.x = max(velocity.x, 0)
		elif direction.x > 0:
			velocity.x = min(velocity.x, 0)


func calculate_acceleration() -> void:
	if is_on_floor():
		acceleration = GROUND_ACCELERATION
	else:
		acceleration = AIR_ACCELERATION


func calculate_friction() -> void:
	if is_on_floor():
		friction = GROUND_FRICTION
	else:
		friction = AIR_FRICTION


func activate_jump() -> void:
	gravity = JUMP_GRAVITY
#	velocity.x += JMUP_BONUS_VELOCITY * direction.x
	velocity.y = -JUMP_VELOCITY
	emit_signal("on_jump")


func set_is_holding_egg(value: bool) -> void:
	is_holding_egg = value
	
	if is_holding_egg:
		EggSprite.show()
		emit_signal("on_taking_egg")
	else:
		EggSprite.hide()
		emit_signal("on_throw_egg")


func activate_stunlock_jump() -> void:
	activate_godmode()
	velocity.y = -STUNLOCK_JUMP_VELOCITY
	var direction_x = -sign(velocity.x)
	
	if direction_x == 0:
		direction_x = Utility.choosei([-1, 1])
	
	velocity.x = direction_x * STUNLOCK_VELOCITY
	
	if is_holding_egg:
		throw_egg(STUNLOCK_THROW_VELOCITY)


func throw_egg(velocity: float) -> void:
	var target_point = global_position + Vector2(THROW_TARGET.x * facing_direction, THROW_TARGET.y)
	set_is_holding_egg(false)
	var egg_instance = egg_scene.instance()
	get_parent().call_deferred("add_child", egg_instance)
	yield(get_tree(), "idle_frame")
	egg_instance.position = EggSprite.global_position
	egg_instance.launch(target_point, velocity)













