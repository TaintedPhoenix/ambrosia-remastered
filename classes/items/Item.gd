
class_name Item extends ItemLike

var spritePath : String
var displayName : String
var rarity : ItemRarity
var description : String
var highlightColor : Color

func get_sprite() -> CompressedTexture2D:
	return load(spritePath)

static func isNull(i : ItemLike) -> bool:
	return i.id == "null"

@warning_ignore("shadowed_variable")
func _init(options : Dictionary = {}) -> void:
	super(options)
	spritePath = options.get("spritePath") if options.has("spritePath") else "res://resources/assets/none.png"
	rarity = options.get("rarity") if options.has("rarity") else ItemRarity.UNOBTAINABLE
	displayName = options.get("displayName") if options.has("displayName") else "Null" 
	description = options.get("description") if options.has("description") else ""
	highlightColor = options.get("highlightColor") if options.has("highlightColor") else rarity.color
