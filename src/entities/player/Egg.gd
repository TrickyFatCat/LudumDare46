class_name Egg
extends Entity

var is_player_near : bool = false

onready var HintLabel : Label = $Hint


func _physics_process(delta) -> void:
	apply_gravity(delta)
	move()


# warning-ignore:unused_argument
func _input(event):
	if InputHandler.is_interact_pressed() and is_player_near:
		Global.player.set_is_holding_egg(true)
		self.queue_free()


# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	HintLabel.show()
	is_player_near = true


# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	HintLabel.hide()
	is_player_near = false
