
class_name ProjectileWeapon extends Weapon

var projectileScenePath : String

@warning_ignore("shadowed_variable")
func _init(id := "sword", spritePath :="res://resources/asssets/items/Sword.png", displayName := "Sword", rarity := ItemRarity.COMMON, description := "A simple steel sword", highlightColor := Color(0,0,0,0), speed := 2.5, size := 1.0, auto :=false, damage := 12.0, knockback := 0.0, projectileScenePath : String = "res://resources/assets/items/Sword.png"):
	super(id, spritePath, displayName, rarity, description, highlightColor, speed, size, auto, damage, knockback)
	self.projectileScenePath = projectileScenePath
	
static func from(options : Dictionary) -> ProjectileWeapon:
	
