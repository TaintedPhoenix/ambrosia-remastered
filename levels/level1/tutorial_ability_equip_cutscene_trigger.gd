extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameData.itemEquipped.connect(func(item, _category):
		if item is AbilityItem and item.id == "whiteshard":
			UI.playCutscene("tutorialDoubleJump")
			queue_free()
		)
