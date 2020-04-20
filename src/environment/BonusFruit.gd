extends Area2D

const POINTS_COST : int = 1

var is_active : bool = true

onready var SpriteNode : AnimatedSprite = $AnimatedSprite
onready var CollectSound : AudioStreamPlayer = $CollectSound


# warning-ignore:unused_argument
func _on_BonusFruit_body_entered(body):
	if SpriteNode.animation != "collect" and !HitPoints.is_low_hitpoints():
		PointsHandler.increase_points(POINTS_COST)
		CollectSound.play()
		SpriteNode.play("collect")
#		is_active = false


func _on_CollectSound_finished():
	queue_free()


func _on_AnimatedSprite_animation_finished():
	if SpriteNode.animation == "collect":
		SpriteNode.stop()
		SpriteNode.hide()
