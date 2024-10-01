extends CanvasLayer

var colordict = {
	"redtopaz" : 0,
	"deepredtopaz" : 0
}


func _ready() -> void:
	$weapon.clearItem()
	$ability.clearItem()
	if GameData.equippedWeapon != null:
		$weapon.setItem(GameData.equippedWeapon)
	if GameData.equippedTrinket != null:
		$ability.setItem(GameData.equippedTrinket)
		if GameData.equippedTrinket is AbilityItem and GameData.equippedTrinket.ability is HealthAbility:
			if GameData.equippedTrinket.id in colordict:
				$health.setColor(colordict[GameData.equippedTrinket.id])
	GameData.itemEquipped.connect(itemEq)
	GameData.itemUnequipped.connect(itemUq)
	
func itemEq(i : Item, cat : String):
	if cat == "Weapon":
		$weapon.setItem(i)
	elif cat == "Ability":
		$ability.setItem(i)
		if i is AbilityItem and i.ability is HealthAbility and i.id in colordict:
			$health.setColor(colordict[i.id])
		else:
			$health.setColor(7)

func itemUq(cat : String):
	if cat == "Weapon":
		$weapon.clearItem()
	elif cat == "Ability":
		$ability.clearItem()
		$health.setColor(7)
