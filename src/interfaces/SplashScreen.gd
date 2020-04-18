extends Control

const WAIT_TIME : float = 1999.25

onready var WaitTimer : Timer = $WaitTimer
onready var LudumSplash : TextureRect = $LudumSplash
onready var TeamSplash : TextureRect = $TeamSplash
onready var current_splash : TextureRect = LudumSplash
onready var TransitionEffect : ColorRect = $TransitionEffect


func _ready() -> void:
	WaitTimer.wait_time = WAIT_TIME
	TransitionEffect.start_opening_transition()


func _on_WaitTimer_timeout() -> void:
	if current_splash == LudumSplash:
		current_splash = TeamSplash
		LudumSplash.hide()
		WaitTimer.start()
	else:
		LevelManager.load_main_menu()


func _on_TransitionEffect_on_screen_opened():
	WaitTimer.start()
