extends Node

signal itemUnequipped(category : String)
signal itemEquipped(item : Item, category : String)
signal inventoryChanged

var player : CharacterBody2D

@onready var inventory : Array[ItemLike] = []

@onready var itemsCollected : Array[String] = []
@onready var tempItems : Array[ItemLike] = []

var equippedWeapon = null
var equippedTrinket = null
var fists = Weapon.new({
	"id" : "punch",
	"displayName" : "Fists",
	"description" : "Your fists, what more is there to say",
	"damage" : 3.0,
	"speed" : 2.0,
	"knockback" : 0.25,
	"attackScene" : "res://scenes/weapons/punch/punch.tscn"
})

func _ready() -> void:
	Loader.game_exited.connect(trash_new_items)
	Loader.scene_reset.connect(trash_new_items)
	Loader.level_complete.connect(save_new_items)
	
func trash_new_items():
	for item in tempItems:
		if item.id in itemsCollected:
			itemsCollected.erase(item.id)
		if item in inventory:
			inventory.erase(item)
		if item == equippedWeapon:
			equippedWeapon = null
			itemUnequipped.emit("Weapon")
			inventoryChanged.emit()
		if item == equippedTrinket:
			equippedTrinket = null
			itemUnequipped.emit("Ability")
			inventoryChanged.emit()
	var td = tempItems
	for item in td:
		tempItems.erase(item)

func save_new_items():
	tempItems = []

func setPlayer(node : CharacterBody2D):
	player = node
	
func collectItem(item : Item):
	if not item.id in itemsCollected:
		tempItems.append(item)
		itemsCollected.append(item.id)
		inventory.append(item)
		inventoryChanged.emit()
func isPlayer(node):
	return (node == player)

func getEquippedItem(category : String):
	if category == "Weapon":
		return equippedWeapon
	elif category == "Ability":
		return equippedTrinket

func equipItem(item : Item):
	if item is Weapon and item in inventory:
		inventory.erase(item)
		if equippedWeapon != null:
			inventory.append(equippedWeapon)
		equippedWeapon = item
		itemEquipped.emit(item, "Weapon")
		inventoryChanged.emit()
	elif item is AbilityItem and item in inventory:
		inventory.erase(item)
		if equippedTrinket != null:
			inventory.append(equippedTrinket)
		equippedTrinket = item
		itemEquipped.emit(item, "Ability")
		inventoryChanged.emit()
		
func unequipItem(category : String):
	if category == "Weapon" and equippedWeapon != null:
		var temp = equippedWeapon
		equippedWeapon = null
		inventory.append(temp)
		itemUnequipped.emit(category)
		inventoryChanged.emit()
	elif category == "Ability" and equippedTrinket != null:
		var temp = equippedTrinket
		equippedTrinket = null
		inventory.append(temp)
		itemUnequipped.emit(category)
		inventoryChanged.emit()
