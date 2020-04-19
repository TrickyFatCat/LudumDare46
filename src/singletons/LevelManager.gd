extends Node


func load_level_by_name(level_name: String) -> void:
	var path = "res://levels/" + level_name + ".tscn"
# warning-ignore:return_value_discarded
	get_tree().change_scene(path)
	HitPoints.sync_hitpoitnts()


func load_level_by_path(path: String) -> void:
# warning-ignore:return_value_discarded
	get_tree().change_scene(path)
	HitPoints.sync_hitpoitnts()


func load_main_menu() -> void:
	load_level_by_path("res://levels/menus/MainMenu.tscn")


func reload_current_level() -> void:
# warning-ignore:return_value_discarded
	get_tree().reload_current_scene()
	HitPoints.sync_hitpoitnts()
