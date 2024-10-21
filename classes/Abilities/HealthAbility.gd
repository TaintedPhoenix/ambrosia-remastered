
class_name HealthAbility extends PassiveAbility

var amount : int
var regenUsed := false

func _init(options : Dictionary = {}):
	super(options)
	amount = options.get("amount") if options.has("amount") else 10



func equip() -> void:
	GameData.player.bonusHealth = amount
	if not regenUsed:
		regenUsed = true
		GameData.player.regen_rate = ((100)/(30.0)) + ((amount)/(3.0))
		await GameData.delay(3)
		GameData.player.regen_rate = ((100)/(30.0))
	
func unequip() -> void:
	GameData.player.bonusHealth -= amount
	GameData.player.regen_rate = ((100)/(30.0))
	if GameData.player.health > GameData.player.maxHealth + GameData.player.bonusHealth:
		GameData.player.health = GameData.player.maxHealth + GameData.player.bonusHealth
