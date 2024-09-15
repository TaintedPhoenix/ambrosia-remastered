extends Node

func findItem(id : String) -> Item:
	for i in range(0, len(items)):
		if items[i].id == id:
			return items[i]
	return Item.new("null", "res://resources/assets/none.png", "None", ItemRarity.UNOBTAINABLE)

var items : Array[Item] = [
	Weapon.new(
		"sword",
		"res://resources/assets/items/Sword.png",
		"Sword",
		ItemRarity.COMMON,
		"A simple steel sword",
		8.0,
		2.5,
		1.0,
		1.0,
		"slash"
	),
	Weapon.new(
		"excalibur",
		"res://resources/assets/items/Excalibur.png",
		"Excalibur",
		ItemRarity.LEGENDARY,
		"A sword pulled from the stone by a hero of outstanding caliber",
		50.0,
		3.5,
		2.0,
		1.5,
		"slash"
	)
]
