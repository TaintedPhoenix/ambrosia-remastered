extends Node2D

func _on_Zone_body_entered(body : CollisionObject2D):
	if GameData.isPlayer(body):
		Loader.resetScene()
	elif body.collision_layer == 3:
		if body.has_method("death"):
			body.death()
		else:
			body.queue_free() 
	
