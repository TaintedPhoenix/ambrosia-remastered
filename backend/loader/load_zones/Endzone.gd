extends Area2D

func _on_Endzone_body_entered(body):
	if GameData.isPlayer(body):
		Loader.startNextLevel()
