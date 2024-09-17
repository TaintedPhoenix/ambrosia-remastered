extends Node

signal itemUnequipped(category : String)
signal itemEquipped(item : Item, category : String)
signal inventoryChanged

var player : CharacterBody2D

@onready var inventory : Array[ItemLike] = []

@onready var itemsCollected : Array[String] = []

var equippedWeapon = null
var fists = Weapon.new({
	"id" : "punch",
	"displayName" : "Fists",
	"description" : "Your fists, what more is there to say",
	"damage" : 3.0,
	"speed" : 2.0,
	"knockback" : 0.25,
	"attackScene" : "res://scenes/weapons/punch/punch.tscn"
})

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
