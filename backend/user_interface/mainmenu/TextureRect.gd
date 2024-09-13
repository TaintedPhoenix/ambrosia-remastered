extends TextureRect


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	anchor_left = 0.5
	anchor_right = 0.5
	anchor_top = 0.5
	anchor_bottom = 0.5
	var texture_size = texture.get_size()
	margin_left = -texture_size.x * rect_scale.x / 2
	margin_right = -texture_size.x * rect_scale.x/ 2
	margin_top = -texture_size.y * rect_scale.y/ 2
	margin_bottom = -texture_size.y * rect_scale.y/ 2
