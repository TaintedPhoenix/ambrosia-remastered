
class_name ItemRarity

var name : String
var color : Color
var value : int

static var UNOBTAINABLE := ItemRarity.new("unobtainable", Color("#663c21"), -2)
static var TRASH := ItemRarity.new("trash", Color("#595959"), -1)
static var COMMON := ItemRarity.new("common", Color("#f0f0f0"), 1)
static var UNCOMMON := ItemRarity.new("uncommon", Color("#41b535"), 2)
static var RARE := ItemRarity.new("rare", Color("#50b1cc"), 4)
static var EPIC := ItemRarity.new("epic", Color("#75278c"), 8)
static var LEGENDARY := ItemRarity.new("legendary", Color("#ed8b2f"), 16)
static var MYTHICAL := ItemRarity.new("mythical", Color("#ed2f2f"), 32)

@warning_ignore("shadowed_variable")
func _init(name : String, color : Color, value : int) -> void:
	self.name = name
	self.color = color
	self.value = value
