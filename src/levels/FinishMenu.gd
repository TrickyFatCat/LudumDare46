extends Level

func _on_FinishMenu_on_load_next_level():
	print_debug("Restart game needs logic")


# warning-ignore:unused_argument
func _on_ExitGame_body_entered(body):
	get_tree().quit()