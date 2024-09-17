
class_name AbilityItem extends Item

var ability : String

@warning_ignore("shadowed_variable")
func _init(options : Dictionary = {}):
	super(options)
	ability = options.get("ability") if options.has("ability") else "doublejump"