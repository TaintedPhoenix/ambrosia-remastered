extends Control

var rotations = {
	"sword" : 45
}

func setRotation(i : Item):
	if i.id in rotations and rotations[i.id] == 45:
		rotation = 45
		position = Vector2(100, 0)
		scale = (200/sqrt(2*((size.x)**2))) * Vector2.ONE
	else:
		rotation = 0
		position = Vector2(0,0)
		scale = Vector2(1,1)



func setItem(i : Item):
	$TextureRect.texture = i.get_sprite()
	setRotation(i)
	
