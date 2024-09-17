
class_name AbilityItem extends Item

var abilityName : String

@warning_ignore("shadowed_variable")
func _init(id : String, spritePath : String, displayName := "", rarity := ItemRarity.UNOBTAINABLE, description := "", highlightColor := Color(0, 0, 0, 0), abilityName := "doublejump"):
	super(id, spritePath, displayName, rarity, description, highlightColor)
	self.abilityName = abilityName
