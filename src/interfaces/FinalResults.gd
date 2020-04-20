extends HBoxContainer

onready var FruitCounter : Label = $FruitCounter


func _ready() -> void:
	FruitCounter.text = String(PointsHandler.points) + "/85"
