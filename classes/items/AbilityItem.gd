
class_name AbilityItem extends Equippable

var ability : Ability

@warning_ignore("shadowed_variable")
func _init(options : Dictionary = {}):
	super(options)
	ability = options.get("ability") if options.has("ability") else Ability.new()
