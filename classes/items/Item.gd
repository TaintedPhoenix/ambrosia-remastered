
class_name Item extends ItemLike

var spritePath : String
var displayName : String
var rarity : ItemRarity
var description : String
var highlightColor : Color

func get_sprite() -> CompressedTexture2D:
	return load(spritePath)

@warning_ignore("shadowed_variable")
func _init(id : String, spritePath : String, displayName := "", rarity := ItemRarity.UNOBTAINABLE, description := "", highlightColor := Color(0, 0, 0, 0)) -> void:
	super(id)
	self.spritePath = spritePath
	self.displayName = displayName
	self.rarity = rarity
	self.description = description
	self.highlightColor = highlightColor
