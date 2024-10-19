extends AnimatedSprite2D

@export var key : String = "e"
@export var instanced = false
@export var showOnStart = false

func init(k : String):
	key = k
	instanced = true
	
func shown():
	visible = true
	play(key.to_lower())
	
func hidden():
	visible = false
	stop()

func _ready() -> void:
	visible = false
	if key == "tab":
		offset.x = 1
	elif key == "mouse1" or key == "esc":
		offset.x = 0.5
	elif key == "e":
		offset.x = -0.5
	else:
		offset.x = 0
	if not instanced:
		$Area2D.scale = Vector2(3.0/scale.x, 3.0/scale.y)
		$Area2D.body_entered.connect(func(body):
			if GameData.isPlayer(body):
				shown()
		)
		$Area2D.body_exited.connect(func(body):
			if GameData.isPlayer(body):
				hidden()
		)
	elif showOnStart:
		shown()
