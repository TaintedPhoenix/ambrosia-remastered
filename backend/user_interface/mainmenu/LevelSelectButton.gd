extends Button

func _ready():
	pressed.connect(buttonpressed)
	
func buttonpressed():
	Loader.loadScenePath("res://backend/user_interface/levelselect/Levelselect.tscn")
