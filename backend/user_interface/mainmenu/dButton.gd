extends Button

func _ready():
	self.connect("pressed", self, "_on_Button_pressed")
	
func _on_Button_pressed():
	GameData.discard = Loader.loadScene(1)
