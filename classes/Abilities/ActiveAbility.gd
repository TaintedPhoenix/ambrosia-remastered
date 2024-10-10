
class_name ActiveAbility extends Ability

var actions : Array
var enabled : bool = false

func _init(options : Dictionary = {}):
	super(options)
	actions = options.get("actions") if options.has("actions") else []

func condition() -> bool:
	return false

func activate() -> void:
	pass
	
