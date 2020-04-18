extends Node

static func get_facing_direction(target: Node2D) -> Vector2:
	return Vector2.RIGHT.rotated(target.global_rotation)


static func get_player_position() -> Vector2:
	return Global.player.global_position


static func get_direction_to_player(target: Node2D) -> Vector2:
	return (get_player_position() - target.global_position).normalized()


static func get_distance_to_player(target: Node2D) -> float:
	return get_player_position().distance_to(target.global_position)


static func play_sound_2d(audio_stream_2d: AudioStreamPlayer2D, sound: AudioStream = null) -> void:
	if sound != null:
		audio_stream_2d.stream = sound
	
	if !audio_stream_2d.playing:
		audio_stream_2d.play()


static func play_sound(audio_stream: AudioStreamPlayer, sound: AudioStream = null) -> void:
	if sound != null:
		audio_stream.stream = sound
	
	if !audio_stream.playing:
		audio_stream.play()
