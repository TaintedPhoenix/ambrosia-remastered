extends Button

var level = int(text)

func _ready():
	if level > Loader.maxLevel:
		disabled = true
	else:
		GameData.discard = connect("pressed", self, "pressed")

func pressed():
	if not disabled:
		Loader.loadScene(level)
