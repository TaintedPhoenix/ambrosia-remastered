extends Node


func _ready() -> void:
	GameData.itemEquipped.connect(func(item, category):
		if category == "Weapon" or item is Weapon:
			UI.playCutscene("tutorialAttack")
			queue_free()
		)
