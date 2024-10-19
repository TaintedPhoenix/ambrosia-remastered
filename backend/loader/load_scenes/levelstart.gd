extends Node2D

var time : float = 0.0
var loadtime : float = 3.25
var levelId : int = 1
var loadDone := false

func init(levelData : Dictionary) -> void:
	$Number.text = levelData.get("number") if levelData.has("number") else "Level -1"
	$Title.text = levelData.get("title") if levelData.has("title") else "Null"
	$Icon.texture = load(levelData.get("iconPath")) if levelData.has("iconPath") else load("res://resources/assets/items/Sword.png")
	levelId = levelData.get("id") if levelData.has("id") else 1

func _ready() -> void:
	get_tree().paused = true
	init(Loader.levelData[Loader.startingLevel])
	$LoadingSpinner.texture = load(["res://resources/assets/items/Sword.png","res://resources/assets/items/Calamity.png","res://resources/assets/items/Excalibur.png","res://resources/assets/items/Bloodied_Cleaver.png","res://resources/assets/items/Bloodborn.png"].pick_random())
	loadtime = 3.25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not loadDone:
		$LoadingSpinner.rotation_degrees -= 360 * delta
		loadtime -= delta
		time += delta
		if time >= 0.5:
			time -= 0.5
			if not $Loading.text == "Loading...":
				$Loading.text += "."
			else:
				$Loading.text = "Loading"
		if loadtime <= 0:
			$LoadingSpinner.visible = false
			$Loading.visible = false
			$Continue.visible = true
			$actionIndicator.shown()
			loadDone = true
	else:
		if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("move_up"):
			Loader.loadLevel(levelId)
			get_tree().paused = false
			set_process(false)
