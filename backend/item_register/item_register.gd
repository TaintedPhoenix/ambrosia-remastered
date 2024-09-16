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
		Color(0, 0, 0, 0),
		8.0,
		0.8,
		1.0,
		1.0,
		"slash"
	),
	AutoswingWeapon.new(
		"bloody_cleaver",
		"res://resources/assets/items/Bloodied_Cleaver.png",
		"Bloody Cleaver",
		ItemRarity.RARE,
		"A hardened steel cleaver, covered with dried blood",
		Color(0,0,0,0),
		10.0,
		1.2,
		1.0,
		0.8,
		"slash"
	),
	Weapon.new(
		"excalibur",
		"res://resources/assets/items/Excalibur.png",
		"Excalibur",
		ItemRarity.EPIC,
		"A sword pulled from the stone by a hero of outstanding caliber",
		Color(0,0,0,0),
		50.0,
		1.1,
		2.0,
		1.5,
		"slash"
	),
	Weapon.new(
		"calamity",
		"res://resources/assets/items/Calamity.png",
		"Calamity",
		ItemRarity.EPIC,
		"A sword forged from black steel and obsidian encrusted with several jewels",
		Color(0,0,0,0),
		45.0,
		1.5,
		2.0,
		1.0,
		"slash"
	)
]
