
class_name Weapon extends Item

var speed : float
var size : float
var auto : bool
var damage : float
var knockback : float
var attackScenePath : String

func _init(options : Dictionary = {}) -> void:
	super(options)
	speed = options.get("speed") if options.has("speed") else 1.0
	size = options.get("size") if options.has("size") else 1.0
	auto = options.get("auto") if options.has("auto") else false
	damage = options.get("damage") if options.has("damage") else 1.0
	knockback = options.get("knockback") if options.has("knockback") else 1.0
	attackScenePath = options.get("attackScenePath") if options.has("attackScenePath") else "res://scenes/weapons/slash/slash.tscn"
