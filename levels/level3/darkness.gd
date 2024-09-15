extends Light2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var darkened = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func eshift(endValue):
	if (endValue < energy):
		while energy > endValue:
			energy -= 0.001
	else:
		while endValue > energy:
			energy += 0.001
		

func _process(_delta):
	"""delta3 += delta
	if delta3<FLT and animState == 0 and flickerCount > 0:
		eg = RNG.randf_range(0, 0.3)
		animState = 1
	if delta3>=FLT and delta3 <FLT*2 and animState == 1 and flickerCount > 0:
		animState = 2
		eshift(energy + eg)
		
	if delta3 >= FLT*2 and animState == 2 and flickerCount > 0:
		flickerCount -= 1
		animState = 0
		delta3 = 0
		nf = RNG.randi_range(3,15)
	
	if delta3 > nf:
		flickerCount = RNG.randi_range(8, 70)
		animState = 0
		delta3 = 0"""
	pass
		
func toggleDarken():
	if darkened == true:
		darkened = false
		eshift(1)
	else:
		darkened = true
		eshift(0.5)
func darken(body):
	if body.name == "Player" and darkened == false:
		toggleDarken()
	
func lighten(body):
	if body.name == "Player" and darkened == true:
		toggleDarken()
		
		
		
