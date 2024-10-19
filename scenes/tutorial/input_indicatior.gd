extends AnimatedSprite2D

@export var key : String = "e"
@export var instanced = false
@export var showOnStart = false
@export var stagger = false
@export var vanish = false

func init(k : String):
	key = k
	instanced = true
	
func shown():
	visible = true
	if not stagger:
		play(key.to_lower())
	else:
		frame = 1
		play(key.to_lower())
	
func hidden():
	visible = false
	stop()

func _ready() -> void:
	visible = false
	match key:
		"tab":
			offset.x = 1
		"mouse1", "esc":
			offset.x = 0.5
		"e", "d", "a":
			offset.x = -0.5
		_:
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
				if vanish:
					queue_free()
		)
	elif showOnStart:
		shown()
