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
	$ItemName.label_settings.font_color = newItem.rarity.color
	$ItemFrame.setItem(newItem)

func clearItem():
	$ItemFrame.clearItem()
	$ItemName.label_settings.font_color = Color("#f0f0f0")
	$ItemName.text = "None"
	
func unequip():
	GameData.unequipItem(category)
	clearItem()
	
func itemEquipped(item : Item, eCat : String):
	if eCat == category:
		setItem(item)
