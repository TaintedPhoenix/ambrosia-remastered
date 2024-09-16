
class_name Weapon extends Item

var damage : float
var speed : float
var knockback : float
var type : String
var size : float

@warning_ignore("shadowed_variable")
func _init(id := "sword", spritePath :="res://resources/asssets/items/Sword.png", displayName := "Sword", rarity := ItemRarity.COMMON, description := "A simple steel sword", highlightColor := Color(0,0,0,0), damage := 8.0, speed := 2.5, knockback := 1.0, size := 1.0, type := "slash") -> void:
	super(id, spritePath, displayName, rarity, description, highlightColor)
	self.damage = damage
	self.speed = speed
	self.size = size
	self.knockback = knockback
	self.type = type
