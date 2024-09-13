extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	GameData.discard = connect("pressed", self, "pressed")
	
func pressed():
	Loader.loadScenePath("res://Global/Backend/Loader/Main Menu/MainMenu.tscn")
