class_name Entity
extends KinematicBody2D

const GROUND_FRICTION : float = 3000.0
const AIR_FRICTION : float = 500.0
const GRAVITY : float = 6000.0

export(float) var max_velocity = 500
export(float) var acceleration = 1000

var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var friction : float = GROUND_FRICTION

onready var StateMachineNode : StateMachine = $StateMachine


func move() -> void:
	velocity = move_and_slide(velocity, Vector2.UP)
