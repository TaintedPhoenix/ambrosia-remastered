
class_name HealthAbility extends Ability

var amount : int

func _init(options : Dictionary = {}):
	super(options)
	amount = options.get("amount") if options.has("amount") else 10
