extends Camera2D

onready var ScreenShaker : Node = $ScreenShake


func _ready() -> void:
	HitPoints.connect("on_player_take_damage", self, "activate_player_shake")
	HitPoints.connect("on_egg_take_damage", self, "activate_egg_shake")


func activate_player_shake() -> void:
	print("hello")
	ScreenShaker.start(0.2, 50, 5)

func activate_egg_shake() -> void:
	ScreenShaker.start(0.2, 50, 10, 1)
