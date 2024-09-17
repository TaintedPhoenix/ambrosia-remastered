
class_name Weapon extends Item

var speed : float
var size : float
var auto : bool
var damage : float
var knockback : float

@warning_ignore("shadowed_variable")
func _init(id := "sword", spritePath :="res://resources/asssets/items/Sword.png", displayName := "Sword", rarity := ItemRarity.COMMON, description := "A simple steel sword", highlightColor := Color(0,0,0,0), speed := 2.5, size := 1.0, auto := false, damage :=8.0, knockback := 0.0) -> void:
	super(id, spritePath, displayName, rarity, description, highlightColor)
	self.speed = speed
	self.size = size
	self.auto = auto
	self.damage = damage
	self.knockback = knockback
