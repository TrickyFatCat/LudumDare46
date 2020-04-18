extends Level

func _ready() -> void:
	Global.player.set_is_holding_egg(true)


# warning-ignore:unused_argument
func _on_ExitGame_body_entered(body):
	get_tree().quit()
