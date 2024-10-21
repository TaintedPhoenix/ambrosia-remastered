extends Node

func findItem(id : String) -> Item:
	for i in range(0, len(items)):
		if items[i].id == id:
			return items[i]
	return Item.new()

var items : Array[Item] = [
	Weapon.new({
		"id" : "sword",
		"spritePath":"res://resources/assets/items/pieces/piece_1.png",
		"displayName":"Sword",
		"rarity" : ItemRarity.COMMON,
		"description" : "A simple iron sword",
		"damage" : 8.0,
		"speed" : 0.8,
	}),
	Weapon.new({
		"id" : "excalibur",
		"spritePath" : "res://resources/assets/items/pieces/piece_20.png",
		"displayName" : "Excalibur",
		"rarity" : ItemRarity.EPIC,
		"description" : "A sword pulled from the stone by a hero of outstanding caliber",
		"damage" : 45.0,
		"speed" : 2.0,
		"knockback" : 1.5,
	}),
	Weapon.new({
		"id" : "calamity",
		"spritePath" : "res://resources/assets/items/pieces/piece_39.png",
		"displayName" : "Calamity",
		"rarity" : ItemRarity.EPIC,
		"description" : "A sword forged from black steel and obsidian",
		"damage" : 45.0,
		"knockback" : 2.5,
		"speed" : 1.1,
		"size" : 2.0
	}),
	AbilityItem.new({
		"id" : "whiteshard",
		"spritePath" : "res://resources/assets/items/trinkets/tile_2_2.png",
		"displayName" : "White Gem Shard",
		"rarity" : ItemRarity.RARE,
		"description" : "A pure white shard of some type of gem. You feel especially light when holding it",
		"ability" : DoubleJumpAbility.new(),
		"highlightColor" : Color("#ffffff")
	}),
	AbilityItem.new({
		"id" : "redtopaz",
		"spritePath" : "res://resources/assets/items/trinkets/tile_0_0.png",
		"displayName" : "Red Topaz",
		"rarity" : ItemRarity.UNCOMMON,
		"description" : "A pure red gem. You feel a bit tougher while holding it",
		"ability" : HealthAbility.new({"id" : "bonushealth", "amount" : 20}),
		"highlightColor" : Color("#f5002d")
	}),
	AbilityItem.new({
		"id" : "deepredtopaz",
		"spritePath" : "res://resources/assets/items/trinkets/tile_0_4.png",
		"displayName" : "Deep Red Topaz",
		"rarity" : ItemRarity.EPIC,
		"description" : "A deep red gem. You feel much tougher while holding it",
		"ability" : HealthAbility.new({"id" : "bonushealth", "amount" : 60}),
		"highlightColor" : Color("#ff0d0d")
	}),
	AbilityItem.new({
		"id" : "whitemarquise",
		"spritePath" : "res://resources/assets/items/trinkets/tile_2_3.png",
		"displayName" : "White Marquise",
		"rarity" : ItemRarity.RARE,
		"description" : "A pure white gem. You feel a bit lighter while holding it",
		"ability" : DashAbility.new({"boost" : 2400, "duration" : 0.25, "cooldown" : 0.5}),
		"highlightColor" : Color("#ffffff")
	})
]
