class_name Player
extends Entity

const JUMP_VELOCITY : float = 800.0
const HURT_VELOCITY : float = 500.0
const GROUND_ACCELERATION : float = 5000.0
const AIR_ACCELERATION : float = 5000.0

var is_holding_egg : bool = false

onready var EggSprite : Sprite = $EggSprite


func _ready() -> void:
	Global.player = self


func calculate_direction_x() -> void:
	direction.x = InputHandler.get_move_right_strength() - InputHandler.get_move_left_strength()


func calculate_velocity_x(delta: float, direction: Vector2) -> void:
	calculate_acceleration()
	calculate_friction()
	
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
	velocity.y = -JUMP_VELOCITY


func set_is_holding_egg(value: bool) -> void:
	is_holding_egg = value
	
	if is_holding_egg:
		EggSprite.show()
	else:
		EggSprite.hide()



















