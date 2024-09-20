extends Control

var MaxHealth : float = 100
var bonusHealth : float = 0
var health : float = 100

var heartScene = preload("res://backend/user_interface/gamehud/healthbar/heart.tscn")
var hearts = []

# Called when the node enters the scene tree for the first time.
@warning_ignore("integer_division")
func _ready() -> void:
	for i in range(int(MaxHealth) / 10 + (1 if int(MaxHealth) % 10 != 0 else 0)):
		var hs = heartScene.instantiate()
		hs.position = Vector2(44*(i-1), 0)
		hs.name = "heart" + str(i)
		add_child(hs)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
