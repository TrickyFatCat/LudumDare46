extends Node

static func get_move_left_strength() -> float:
	return Input.get_action_strength("move_left")


static func get_move_right_strength() -> float:
	return Input.get_action_strength("move_right")


static func is_movent_x_inputs_pressed() -> bool:
	return get_move_left_strength() != 0 or get_move_right_strength() != 0


static func is_jump_pressed() -> bool:
	return Input.is_action_just_pressed("jump")


static func is_dash_pressed() -> bool:
	return Input.is_action_just_pressed("dash")


static func is_interact_pressed() -> bool:
	return Input.is_action_just_pressed("interact")


static func is_shoot_pressed() -> bool:
	return Input.is_action_pressed("shoot")
