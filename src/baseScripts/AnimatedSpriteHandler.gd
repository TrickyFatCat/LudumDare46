extends AnimatedSprite

const NORMAL_COLOR : Color = Color.white
const DAMAGE_COLOR : Color = Color.red
const BLINK_TIME : float = 0.15

var is_blinking_active : bool = false

onready var TweenNode : Tween = $Tween


func flip_sprite(direction: Vector2) -> void:
	if direction.x < 0:
		flip_h = true
	elif direction.x > 0:
		flip_h = false


func activate_blinking() -> void:
	if is_blinking_active:
		print("Activate blinking")
		TweenNode.interpolate_property(self, "self_modulate", DAMAGE_COLOR, NORMAL_COLOR, BLINK_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		TweenNode.start()

func _on_Tween_tween_all_completed():
	activate_blinking()


func _on_GodModeTimer_timeout():
	is_blinking_active = false
