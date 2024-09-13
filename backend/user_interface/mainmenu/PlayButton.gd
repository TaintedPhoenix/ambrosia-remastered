extends Button

func _ready():
	pressed.connect(buttonpressed)
	
func buttonpressed():
	Loader.loadLevel(1)
