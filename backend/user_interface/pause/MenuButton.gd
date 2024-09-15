extends Button


func _ready():
	pressed.connect(onpress)
	
func onpress():
	Loader.loadScenePath("res://Global/Backend/Loader/Main Menu/MainMenu.tscn")
