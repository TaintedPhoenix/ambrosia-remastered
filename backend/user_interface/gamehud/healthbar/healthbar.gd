extends Control

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$TextureRect.modulate = Color.from_ok_hsl(0.0, 1.0, 1.0, GameData.player.health/(GameData.player.maxHealth+GameData.player.bonusHealth))
