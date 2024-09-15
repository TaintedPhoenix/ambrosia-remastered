extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(body_ent)
	
func body_ent(body):
	if GameData.isPlayer(body):
		wake()
			
func wake():
	$"../AnimatedSprite".play()
	$"..".set_physics_process(true)
