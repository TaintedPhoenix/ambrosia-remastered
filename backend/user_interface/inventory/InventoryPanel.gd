extends Panel

func _ready() -> void:
	scale = (get_viewport_rect().size / Vector2(1920, 1080))
	if scale.x < scale.y:
		scale = Vector2(scale.x, scale.x)
	else:
		scale = Vector2(scale.y, scale.y)
	position = (get_viewport_rect().size / 2) - (size*scale / 2)
	get_tree().get_root().size_changed.connect(windowResized)

func windowResized():
	scale = (get_viewport_rect().size / Vector2(1920, 1080))
	if scale.x < scale.y:
		scale = Vector2(scale.x, scale.x)
	else:
		scale = Vector2(scale.y, scale.y)
	position = (get_viewport_rect().size / 2) - (size*scale / 2)
