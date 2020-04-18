class_name Player
extends Entity

const JUMP_VELOCITY : float = 500.0
const JUMP_GRAVITY : float = 1750.0
const JMUP_BONUS_VELOCITY : float = 150.0
const HURT_VELOCITY : float = 500.0
const GROUND_ACCELERATION : float = 5000.0
const AIR_ACCELERATION : float = 5000.0
const THROW_TARGET : Vector2 = Vector2(512, 128)

var is_holding_egg : bool = false
var facing_direction : int = 1

onready var EggSprite : Sprite = $EggSprite
onready var egg_scene : PackedScene = preload("res://scenes/entities/player/Egg.tscn")


func _ready() -> void:
	Global.player = self


# warning-ignore:unused_argument
func _input(event):
	if InputHandler.is_shoot_pressed() and is_holding_egg:
		set_is_holding_egg(false)
		var egg_instance = egg_scene.instance()
		egg_instance.global_position = EggSprite.global_position
		var target_point = global_position + Vector2(THROW_TARGET.x * facing_direction, THROW_TARGET.y)
		egg_instance.launch(target_point)
		get_parent().add_child(egg_instance)


func calculate_direction_x() -> void:
	direction.x = InputHandler.get_move_right_strength() - InputHandler.get_move_left_strength()


func calculate_velocity_x(delta: float, direction: Vector2) -> void:
	if direction.x != 0 and abs(velocity.x) <= max_velocity:
		velocity.x += acceleration * direction.x * delta
		velocity.x = clamp(velocity.x, -max_velocity, max_velocity)
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
	velocity.x += JMUP_BONUS_VELOCITY * direction.x
	velocity.y = -JUMP_VELOCITY


func set_is_holding_egg(value: bool) -> void:
	is_holding_egg = value
	
	if is_holding_egg:
		EggSprite.show()
	else:
		EggSprite.hide()



















