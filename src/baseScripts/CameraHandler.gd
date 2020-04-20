extends Camera2D

onready var ScreenShaker : Node = $ScreenShake


func _ready() -> void:
# warning-ignore:return_value_discarded
	HitPoints.connect("on_player_take_damage", self, "activate_player_shake")
# warning-ignore:return_value_discarded
	HitPoints.connect("on_egg_take_damage", self, "activate_egg_shake")


func activate_player_shake() -> void:
	ScreenShaker.start(0.2, 50, 1)

func activate_egg_shake() -> void:
	ScreenShaker.start(0.2, 50, 2, 1)
