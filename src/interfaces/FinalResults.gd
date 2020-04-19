extends HBoxContainer

onready var FruitCounter : Label = $FruitCounter


func _ready() -> void:
	FruitCounter.text = "x " + String(PointsHandler.points)
