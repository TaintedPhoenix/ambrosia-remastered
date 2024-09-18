extends Control


@export var category : String = "Weapon"

func _ready() -> void:
	$Type.text = category
	var eq = GameData.getEquippedItem(category)
	if eq != null:
		setItem(eq)
	GameData.itemEquipped.connect(itemEquipped)

func setItem(newItem : Item):
	$ItemName.text = newItem.displayName
	$ItemName.add_theme_color_override("font_color", newItem.rarity.color)
	$ItemFrame.setItem(newItem)

func clearItem():
	$ItemFrame.clearItem()
	$ItemName.add_theme_color_override("font_color", Color(1,1,1))
	$ItemName.text = "None"
	
func unequip():
	GameData.unequipItem(category)
	clearItem()
	
func itemEquipped(item : Item, eCat : String):
	if eCat == category:
		setItem(item)
