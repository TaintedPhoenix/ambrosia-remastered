extends Node

signal itemUnequipped(category : String)
signal itemEquipped(item : Item, category : String)
signal inventoryChanged

var player : CharacterBody2D

@onready var inventory : Array[ItemLike] = []

@onready var itemsCollected : Array[String] = []

var equippedWeapon = null
var fists = Weapon.new("punch", "res://resources/assets/none.png", "Fists", ItemRarity.UNOBTAINABLE, "Your fists, what more is there to say", Color(0,0,0,0), 2.0, 3.0, 0.25, 0.25, "punch")

func setPlayer(node : CharacterBody2D):
	player = node
	
func collectItem(item : Item):
	if not item.id in itemsCollected:
		itemsCollected.append(item.id)
		inventory.append(item)
		inventoryChanged.emit()
	
func isPlayer(node):
	return (node == player)

func getEquippedItem(category : String):
	if category == "Weapon":
		return equippedWeapon

func equipItem(item : Item):
	if item is Weapon and item in inventory:
		inventory.erase(item)
		if equippedWeapon != null:
			inventory.append(equippedWeapon)
		equippedWeapon = item
		itemEquipped.emit(item, "Weapon")
		inventoryChanged.emit()
		
func unequipItem(category : String):
	if category == "Weapon" and equippedWeapon != null:
		var temp = equippedWeapon
		equippedWeapon = null
		inventory.append(temp)
		itemUnequipped.emit(category)
		inventoryChanged.emit()
