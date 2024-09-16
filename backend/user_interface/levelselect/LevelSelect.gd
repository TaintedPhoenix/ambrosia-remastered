extends Button

var level = int(text)

func _ready():
	position = Vector2(((level-1) % 5)*40 + 20, ((level-1)/5)*40 + 20)
	
	if level > Loader.maxLevel:
		disabled = true
	else:
		pressed.connect(onpress)

func onpress():
	if not disabled:
		Loader.loadLevel(level)
		
