
class_name HealthAbility extends PassiveAbility

var amount : int

func _init(options : Dictionary = {}):
	super(options)
	amount = options.get("amount") if options.has("amount") else 10

func equip() -> void:
	GameData.player.bonusHealth = amount
	
func unequip() -> void:
	GameData.player.bonusHealth -= amount
	if GameData.player.health > GameData.player.maxHealth + GameData.player.bonusHealth:
		GameData.player.health = GameData.player.maxHealth + GameData.player.bonusHealth
