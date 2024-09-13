extends TextureRect

const original_aspect_ratio := 3072.0 / 1728.0
const original_size = Vector2(3072.0, 1728.0)

func _ready() -> void:
	var vps = get_viewport_rect().size
	if (float(vps.x) / float(vps.y) >= original_aspect_ratio):
		var s = ((1/original_aspect_ratio) * vps.x)/original_size.y
		scale = Vector2(s, s)
	else:
		var s = (original_aspect_ratio * vps.y)/original_size.x
		scale = Vector2(s,s)
	print(scale)
	get_tree().get_root().size_changed.connect(windowResized)
	
func windowResized():
	var vps = get_viewport_rect().size
	if (float(vps.x) / float(vps.y) >= original_aspect_ratio):
		var s = ((1/original_aspect_ratio) * vps.x)/original_size.y
		scale = Vector2(s, s)
	else:
		var s = (original_aspect_ratio * vps.y)/original_size.x
		scale = Vector2(s,s)
