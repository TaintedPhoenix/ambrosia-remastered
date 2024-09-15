extends Node2D

signal main_scene_changed
# Loader.gd AKA Antony's funny playground of suffering :D
# lol that was nothing -2024 Antony

var currentLevel : int = 1
var maxLevel : int = 1

func _ready() -> void:
	for kid in $"..".get_children():
		if kid is CanvasItem:
			kid.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST

func loadLevel(id : int) -> void: #Will take a level ID (ex. 5) and load the associated level
	get_tree().change_scene_to_file("res://levels/level%s/level%s.tscn" % [str(id), str(id)])
	UI.state = "game"
	main_scene_changed.emit()
	
func resetScene() -> void:
	call_deferred("rs")

func rs():
	get_tree().reload_current_scene()

func nextLevel() -> void:
	if currentLevel <= maxLevel:
		loadLevel(currentLevel+1)
	
func loadScenePath(path : String) -> void:
	get_tree().change_scene_to_file(path)
	UI.state = "other"
	main_scene_changed.emit()
