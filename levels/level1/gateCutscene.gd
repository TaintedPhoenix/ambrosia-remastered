extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(func(body):
		if GameData.isPlayer(body) and not $"..".open:
			UI.playCutscene("tutorialGate")
			queue_free()
		)
