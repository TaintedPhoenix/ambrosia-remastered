extends CanvasLayer



func _ready() -> void:
	$weapon.clearItem()
	$ability.clearItem()
	if GameData.equippedWeapon != null:
		$weapon.setItem(GameData.equippedWeapon)
	if GameData.equippedTrinket != null:
		$ability.setItem(GameData.equippedTrinket)
	GameData.itemEquipped.connect(itemEq)
	GameData.itemUnequipped.connect(itemUq)
	
func itemEq(i : Item, cat : String):
	if cat == "Weapon":
		$weapon.setItem(i)
	elif cat == "Ability":
		$ability.setItem(i)

func itemUq(cat : String):
	if cat == "Weapon":
		$weapon.clearItem()
	elif cat == "Ability":
		$ability.clearItem()
