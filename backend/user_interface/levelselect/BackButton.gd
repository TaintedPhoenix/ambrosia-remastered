extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(onpress)
	
func onpress():
	Loader.loadScenePath("res://backend/user_interface/mainmenu/MainMenu.tscn")
