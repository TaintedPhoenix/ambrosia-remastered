extends Button

func _ready():
	pressed.connect(buttonpressed)
	
func buttonpressed():
	Loader.startLevel(1)
