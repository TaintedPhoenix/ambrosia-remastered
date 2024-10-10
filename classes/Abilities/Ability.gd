

class_name Ability

var id : String

func _init(options : Dictionary = {}):
	id = options.get("id") if options.has("id") else "null"

func process(_delta) -> void:
	pass

func equip() -> void:
	pass

func unequip() -> void:
	pass
