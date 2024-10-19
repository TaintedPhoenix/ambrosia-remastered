extends StaticBody2D

@export var requirements : Array[CharacterBody2D] = []
var open := false

func _ready() -> void:
	if len(requirements) == 0:
		open = true
		$AnimationPlayer.play("open")
	else:
		for i in requirements:
			if i.has_signal("dead"):
				i.dead.connect(reqKilled)

func reqKilled(node : CharacterBody2D):
	requirements.erase(node)
	if len(requirements) <= 0:
		open = true
		$AnimationPlayer.play("open")
