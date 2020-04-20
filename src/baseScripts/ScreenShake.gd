extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude : int = 0
var priority : int = 0

onready var CameraNode : Camera2D = get_parent()
onready var Frequency : Timer = $Frequency
onready var Duration : Timer = $Duration
onready var TweenShake : Tween = $ShakeTween


# warning-ignore:shadowed_variable
# warning-ignore:shadowed_variable
func start(duration: float = 0.2, frequency: float = 15, amplitude: int = 16, priority: int = 0) -> void:
	if priority >= self.priority:
		self.amplitude = amplitude
		Duration.wait_time = duration
		Frequency.wait_time = 1 / frequency
		Duration.start()
		Frequency.start()
		_new_shake()


func _new_shake() -> void:
	var rand = Vector2.ZERO
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
# warning-ignore:return_value_discarded
	TweenShake.interpolate_property(CameraNode, "offset", CameraNode.offset, rand, Frequency.wait_time, TRANS, EASE)
# warning-ignore:return_value_discarded
	TweenShake.start()


func _reset() -> void:
# warning-ignore:return_value_discarded
	TweenShake.interpolate_property(CameraNode, "offset", CameraNode.offset, Vector2.ZERO, Frequency.wait_time, TRANS, EASE)
# warning-ignore:return_value_discarded
	TweenShake.start()
	priority = 0


func _on_Duration_timeout():
	_reset()
	Frequency.stop()


func _on_Frequency_timeout():
	_new_shake()
