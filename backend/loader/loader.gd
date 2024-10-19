extends Node2D

signal main_scene_changed
signal level_complete
signal scene_reset
signal game_exited
# Loader.gd AKA Antony's funny playground of suffering :D
# lol that was nothing -2024 Antony

var currentLevel : int = 1
var maxLevel : int = 2
var loading : bool = false
var startingLevel : int = 1

var levelData := {
	1: {
		"title" : "Tutorial",
		"number" : "Level 1",
		"id" : 1,
		"iconPath" : "res://resources/assets/items/trinkets/tile_2_0.png"
	},
	2 : {
		"title" : "Ilan's Level",
		"number" : "Level 2",
		"id" : 2,
		"iconPath" : "res://resources/assets/environment/trees/tree2.png"
	}
}

func _ready() -> void:
	for kid in $"..".get_children():
		if kid is CanvasItem:
			kid.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST

func loadLevel(id : int) -> void: #Will take a level ID (ex. 5) and load the associated level
	loading = true
	call_deferred("cs", "res://levels/level%s/level%s.tscn" % [str(id), str(id)])
	UI.state = "game"
	main_scene_changed.emit()
	
func death() -> void:
	loading = true
	call_deferred("cs", "res://backend/loader/load_scenes/death.tscn")
	UI.state = "other"
	main_scene_changed.emit()
	
func startLevel(id : int) -> void:
	loading = true
	startingLevel = id
	call_deferred("cs", "res://backend/loader/load_scenes/levelstart.tscn")
	UI.state = "other"
	main_scene_changed.emit()
	

	
func cs(filename : String):
	get_tree().change_scene_to_file(filename)
	loading = false
	
func resetLevel() -> void:
	loading = true
	call_deferred("cs", "res://levels/level%s/level%s.tscn" % [str(currentLevel), str(currentLevel)])
	UI.state = "game"
	scene_reset.emit()
	main_scene_changed.emit()
	
func resetScene() -> void:
	loading = true
	call_deferred("rs")

func rs():
	get_tree().reload_current_scene()
	scene_reset.emit()
	loading = false

func startNextLevel() -> void:
	if currentLevel <= maxLevel:
		startLevel(currentLevel+1)
		level_complete.emit()

func nextLevel() -> void:
	if currentLevel <= maxLevel:
		loadLevel(currentLevel+1)
		level_complete.emit()
	
func loadScenePath(path : String) -> void:
	loading = true
	call_deferred("cs", path)
	UI.state = "other"
	main_scene_changed.emit()
	game_exited.emit()
