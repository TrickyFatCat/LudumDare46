extends Node

export(AudioStream) var throw_sound
export(AudioStream) var take_sound

onready var Parent : Player = get_parent()
onready var StepPauseTimer : Timer = $StepPauseTimer
onready var HitSound : AudioStreamPlayer = $Hit
onready var EggSound : AudioStreamPlayer = $EggSound
onready var JumpSound : AudioStreamPlayer = $Jump
onready var StepSound : AudioStreamPlayer = $StepSound
onready var EggDamageSound : AudioStreamPlayer = $EggDamage


func _ready():
# warning-ignore:return_value_discarded
	HitPoints.connect("on_player_take_damage", self, "play_hit_sound")
# warning-ignore:return_value_discarded
	HitPoints.connect("on_egg_take_damage", self, "play_egg_damage_sound")
# warning-ignore:return_value_discarded
	Parent.connect("on_taking_egg", self, "play_take_sound")
# warning-ignore:return_value_discarded
	Parent.connect("on_throw_egg", self, "play_throw_sound")
# warning-ignore:return_value_discarded
	Parent.connect("on_jump", self, "play_jump_sound")
# warning-ignore:return_value_discarded
	Parent.connect("on_move", self, "play_step_sound")


func play_hit_sound() -> void:
	Utility.play_sound(HitSound)


func play_take_sound() -> void:
	Utility.play_sound(EggSound, take_sound)


func play_throw_sound() -> void:
	Utility.play_sound(EggSound, throw_sound)


func play_jump_sound() -> void:
	Utility.play_sound(JumpSound)


func play_step_sound() -> void:
	if StepPauseTimer.is_stopped():
		Utility.play_sound(StepSound)
		StepPauseTimer.start()


func play_egg_damage_sound() -> void:
	Utility.play_sound(EggDamageSound)
