extends Node

func findItem(id : String) -> Item:
	for i in range(0, len(items)):
		if items[i].id == id:
			return items[i]
	return Item.new()

var items : Array[Item] = [
	Weapon.new({
		"id" : "sword",
		"spritePath":"res://resources/assets/items/Sword.png",
		"displayName":"Sword",
		"rarity" : ItemRarity.COMMON,
		"description" : "A simple steel sword",
		"damage" : 8.0,
		"speed" : 0.8,
	}),
	Weapon.new({
		"id" : "bloody_cleaver",
		"spritePath" : "res://resources/assets/items/Bloodied_Cleaver.png",
		"displayName" : "Bloody Cleaver",
		"rarity" : ItemRarity.RARE,
		"description" : "A hardened steel cleaver, covered with dried blood",
		"damage" : 10.0,
		"speed" : 1.0,
		"knockback" : 0.8,
		"auto" : true
	}),
	Weapon.new({
		"id" : "excalibur",
		"spritePath" : "res://resources/assets/items/Excalibur.png",
		"displayName" : "Excalibur",
		"rarity" : ItemRarity.EPIC,
		"description" : "A sword pulled from the stone by a hero of outstanding caliber",
		"damage" : 50.0,
		"speed" : 1.1,
		"knockback" : 2.0,
		"size" : 1.5,
	}),
	Weapon.new({
		"id" : "calamity",
		"spritePath" : "res://resources/assets/items/Calamity.png",
		"displayName" : "Calamity",
		"rarity" : ItemRarity.EPIC,
		"description" : "A sword forged from black steel and obsidian encrusted with several jewels",
		"damage" : 45.0,
		"knockback" : 1.5,
		"speed" : 2.0,
	}),
	AbilityItem.new({
		"id" : "redshard",
		"spritePath" : "res://resources/assets/items/trinkets/tile_2_0.png",
		"displayName" : "Red Shard",
		"rarity" : ItemRarity.RARE,
		"description" : "A pure red shard of some type of gem. You feel especially light when holding it",
		"ability" : Ability.new({"id" : "doublejump"}),
		"highlightColor" : Color("#f5002d")
	})
]
