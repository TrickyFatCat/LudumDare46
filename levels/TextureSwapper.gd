extends TextureRect


var textures = [
	load("res://assets/backgrounds/Blue.png"),
	load("res://assets/backgrounds/Brown.png"),
	load("res://assets/backgrounds/Gray.png"),
	load("res://assets/backgrounds/Green.png"),
	load("res://assets/backgrounds/Pink.png"),
	load("res://assets/backgrounds/Purple.png"),
	load("res://assets/backgrounds/Yellow.png")
]

func _ready():
	var index = randi() % textures.size() - 1
	texture = textures[index]
