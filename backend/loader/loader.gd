extends Node2D

# Loader.gd AKA Antony's funny playground of suffering :D
# lol that was nothing -2024 Antony

var currentLevel : int = 1
var maxLevel : int = 1

func loadLevel(id : int) -> void: #Will take a level ID (ex. 5) and load the associated level
	get_tree().change_scene_to_file("res://levels/level%s/level%s.tscn" % [str(id), str(id)])
	
func resetScene() -> void:
	get_tree().reload_current_scene()
	
func nextLevel() -> void:
	if currentLevel <= maxLevel:
		loadLevel(currentLevel+1)
	
func loadScenePath(path : String) -> void:
	get_tree().change_scene_to_file(path)
