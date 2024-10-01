extends Control

func setColor(sp :int):
	var x = (16 * sp) % 64
	var y = int(sp / 4) * 16
	$TextureRect.texture.region.position = Vector2(x, y)
	$TextureRect2.texture.region.position = Vector2(x, y)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$TextureRect.modulate = Color.from_ok_hsl(0.0, 1.0, 1.0, GameData.player.health/(GameData.player.maxHealth+GameData.player.bonusHealth))
