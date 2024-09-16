extends Node2D
@export var levelId = 20
@export var LEVELNAME = "Insert LevelName Here"
@export var PLAYER_START_POS = Vector2(32, 0)
@export var CAMERA_LIMITS = [-100000, -100000, 100000, 10000000]
@export var EXT = true

func _ready():
	UI.state = "game"
	UI.scene_changed()
