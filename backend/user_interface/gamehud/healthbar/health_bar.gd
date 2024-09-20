extends Control

var maxHealth : float = 100
var bonusHealth : float = 20
var health : float = 100

var heartScene = preload("res://backend/user_interface/gamehud/healthbar/heart.tscn")
var hearts = []

# Called when the node enters the scene tree for the first time.
@warning_ignore("integer_division")
func _ready() -> void:
	health = maxHealth + bonusHealth
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TextureRect.modulate = Color.from_hsv(0, 0.0, 0.0)
	health -= 20 * delta
	
