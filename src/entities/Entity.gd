class_name Entity
extends KinematicBody2D

const GROUND_FRICTION : float = 2500.0
const BASE_GRAVITY : float = 3500.0
const AIR_FRICTION : float = 50.0
const INVULNERABILITY_TIME : float = 1.25

export(float) var max_velocity = 500
export(float) var acceleration = 1000

var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var friction : float = GROUND_FRICTION
var gravity : float = BASE_GRAVITY
var is_vulnerable : bool = true

onready var StateMachineNode : StateMachine = $StateMachine
onready var GodModeTimer : Timer = $GodModeTimer
onready var SpriteNode : AnimatedSprite = $AnimatedSprite


func _ready() -> void:
	GodModeTimer.wait_time = INVULNERABILITY_TIME


func move() -> void:
	velocity = move_and_slide(velocity, Vector2.UP)


func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta


func activate_godmode() -> void:
	if is_vulnerable:
		is_vulnerable = false
		GodModeTimer.start()
		SpriteNode.is_blinking_active = true
		SpriteNode.activate_blinking()


func _on_GodModeTimer_timeout():
	is_vulnerable = true
