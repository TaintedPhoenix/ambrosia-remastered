extends Button

func _ready():
	pressed.connect(buttonpressed)
	
func buttonpressed():
	get_tree().quit()
