extends Panel

@export var placeholderSprite : Texture2D = preload("res://resources/assets/misc/icon_sword.png")
@export var clickable : bool = true

func _ready() -> void:
	$TextureRect.texture = placeholderSprite
	if clickable:
		$Button.pressed.connect(clicked)
	else:
		$Button.disabled = true
	
func setItem(item : Item) -> void:
	$TextureRect.texture = item.get_sprite()
	
func clearItem() -> void:
	$TextureRect.texture = placeholderSprite

func clicked() -> void:
	if not clickable:
		return
	if $"..".has_method("unequip"):
		$"..".unequip()
	elif $"..".has_method("clearItem"):
		$"..".clearItem()
	else:
		clearItem()
