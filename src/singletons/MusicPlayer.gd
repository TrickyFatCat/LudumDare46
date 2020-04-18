extends AudioStreamPlayer

var tracks = [
	"res://assets/sounds/bgm_adventures.ogg",
	"res://assets/sounds/bgm_summerPark.ogg"
	]
var track_index : int = -1
var previous_track_index : int = -1


func _ready() -> void:
	connect("finished", self, "play_new_track")
	GameManager.connect("on_start_game", self, "_choose_new_track")
	GameManager.connect("on_end_game", self, "_stop_music")
	_play_new_track()


func _play_new_track() -> void:
	if GameManager.state != GameManager.states.menu:
		choose_new_track()


func _choose_new_track() -> void:
	var track = null
	var new_track_index = randi() % tracks.size()
	
	while new_track_index == previous_track_index:
		new_track_index = randi() % tracks.size()
		
	if new_track_index != previous_track_index:
		previous_track_index = track_index
		track = tracks[new_track_index]
		stream = load(track)
		play()


func _stop_music() -> void:
	previous_track_index = track_index
	stop()
