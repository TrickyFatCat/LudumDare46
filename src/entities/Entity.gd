class_name Entity
extends KinematicBody2D

const GROUND_FRICTION : float = 2500.0
const BASE_GRAVITY : float = 3500.0
const AIR_FRICTION : float = 50.0

export(int) var max_hit_points = 1
export(float) var max_velocity = 500
export(float) var acceleration = 1000

var direction : Vector2 = Vector2.ZERO
var velocity : Vector2 = Vector2.ZERO
var friction : float = GROUND_FRICTION
var gravity : float = BASE_GRAVITY

onready var StateMachineNode : StateMachine = $StateMachine
onready var HitPoints : Node = $HitPoints


func _ready() -> void:
	HitPoints.set_hitpoints(max_hit_points)


func move() -> void:
	velocity = move_and_slide(velocity, Vector2.UP)


func apply_gravity(delta: float) -> void:
	velocity.y += gravity * delta
