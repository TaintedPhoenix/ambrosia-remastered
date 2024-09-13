extends Control



func _ready() -> void:
	position = (get_viewport_rect().size / 2) - (size*scale/2)
	position.y = int((150/1080.0)*get_viewport_rect().size.y)
	get_tree().get_root().size_changed.connect(windowResized)
	
func windowResized():
	position = (get_viewport_rect().size / 2) - (size*scale/2)
	position.y = int((150/1080.0)*get_viewport_rect().size.y)
