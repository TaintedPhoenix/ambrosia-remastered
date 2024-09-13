extends Button


func _ready():
	GameData.discard = connect("pressed", self, "pressed")
	
func pressed():
	GlobalInterface.removeHudElement("pause")
	GameData.discard = Loader.loadScenePath("res://Global/Backend/Loader/Main Menu/MainMenu.tscn")
