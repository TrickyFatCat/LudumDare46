extends AnimatedSprite

func flip_sprite(direction: Vector2) -> void:
	if direction.x < 0:
		flip_h = true
	elif direction.x > 0:
		flip_h = false
