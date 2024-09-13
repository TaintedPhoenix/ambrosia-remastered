extends Panel



func _ready() -> void:
	size = $VBoxContainer.size + Vector2(10, 10)
	position = (get_viewport_rect().size / 2) - (size*scale/2)
	get_tree().get_root().size_changed.connect(windowResized)
	
func windowResized():
	position = (get_viewport_rect().size / 2) - (size*scale/2)
