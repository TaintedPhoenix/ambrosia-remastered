extends Control

@onready var ogScale = scale 
@onready var ogPos = position

var rotations = {
	"sword" : 45,
	"bloody_cleaver" : 45
}

func setRotation(i : Item):
	if i.id in rotations and rotations[i.id] == 45:
		rotation_degrees = 45
		scale = (200/sqrt(2*((size.x)**2))) * ogScale
		position = Vector2(ogScale.x * 100, 0) + ogPos
	else:
		rotation_degrees = 0
		position = ogPos
		scale = ogScale



func setItem(i : Item):
	$TextureRect.texture = i.get_sprite()
	setRotation(i)
	$TextureRect.visible = true

func clearItem():
	$TextureRect.visible = false
