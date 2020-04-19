extends Node

signal on_points_changed()

var points: int = 0


func increase_points(value: int) -> void:
	points += value
	emit_signal("on_points_changed")


func reset_points() -> void:
	points = 0
	emit_signal("on_points_changed")
