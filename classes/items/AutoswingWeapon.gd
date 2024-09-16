
class_name AutoswingWeapon extends Weapon


func _init(id := "sword", spritePath :="res://resources/asssets/items/Sword.png", displayName := "Sword", rarity := ItemRarity.COMMON, description := "A simple steel sword", highlightColor := Color(0,0,0,0), damage := 8.0, speed := 2.5, knockback := 1.0, size := 1.0, type := "slash") -> void:
	super(id, spritePath, displayName, rarity, description, highlightColor, damage, speed, size, knockback, type)
