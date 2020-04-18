extends Node


func load_level_by_name(level_name: String) -> void:
	var path = "res://levels/" + level_name + ".tscn"
	get_tree().change_scene(path)


func load_level_by_path(path: String) -> void:
	get_tree().change_scene(path)


func load_main_menu() -> void:
	load_level_by_path("res://levels/menus/MainMenu.tscn")


func reload_current_level() -> void:
	get_tree().reload_current_scene()
