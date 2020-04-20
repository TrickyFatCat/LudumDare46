extends Control

const WAIT_TIME : float = 1.5

onready var TransitionWait : Timer = $TransitionWait
onready var SplashWait : Timer = $SplashWait
onready var LudumSplash : TextureRect = $LudumSplash
onready var TeamSplash : TextureRect = $TeamSplash
onready var current_splash : TextureRect = LudumSplash
onready var TransitionEffect : ColorRect = $TransitionEffect
onready var GooseSound : AudioStreamPlayer = $GooseSound


func _ready() -> void:
	TransitionWait.wait_time = WAIT_TIME
	SplashWait.wait_time = WAIT_TIME
	TransitionWait.start()


func _on_SplashWait_timeout():
	TransitionEffect.start_closing_transition()


func _on_TransitionWait_timeout():
	if current_splash != null:
		TransitionEffect.start_opening_transition()
	else:
		LevelManager.load_main_menu()


func _on_TransitionEffect_on_screen_opened():
	if current_splash == LudumSplash:
		SplashWait.start()
	else:
		SplashWait.start()
		GooseSound.play()


func _on_TransitionEffect_on_screen_closed():
	if current_splash == LudumSplash:
		current_splash.hide()
		current_splash = TeamSplash
		TransitionWait.start()
	else:
		current_splash = null
		TransitionWait.start()
