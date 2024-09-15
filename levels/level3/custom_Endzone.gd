extends Area2D

func _ready():
	body_entered.connect(_on_Endzone_body_entered)

func _on_Endzone_body_entered(body):
	if GameData.isPlayer(body):
		Loader.nextLevel()
