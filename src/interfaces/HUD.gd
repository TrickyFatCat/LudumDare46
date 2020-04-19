extends Control

onready var PlayerHitpoints : Label = $HBoxContainer/HBoxContainer/PlayerHitpoints
onready var EggHitpoints : Label = $HBoxContainer/HBoxContainer2/EggHitpoints


func _ready() -> void:
# warning-ignore:return_value_discarded
	HitPoints.connect("on_player_take_damage", self, "update_player_hitpoints")
# warning-ignore:return_value_discarded
	HitPoints.connect("on_egg_take_damage", self, "update_egg_hitpoints")
	update_player_hitpoints()
	update_egg_hitpoints()


func update_player_hitpoints() -> void:
	PlayerHitpoints.text = "x " + String(HitPoints.player_hitpoints)


func update_egg_hitpoints() -> void:
	EggHitpoints.text = "x " + String(HitPoints.egg_hitpoints)
