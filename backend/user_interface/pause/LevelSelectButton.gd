extends Button


func _ready():
	pressed.connect(onpress)
	
func onpress():
	Loader.loadScenePath("res://backend/user_interface/levelselect/levelselect.tscn")
