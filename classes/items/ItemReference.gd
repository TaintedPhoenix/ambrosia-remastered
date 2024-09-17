
class_name ItemReference extends ItemLike

@warning_ignore("shadowed_variable")
func _init(options : Dictionary = {}) -> void:
	super(options)

func resolve() -> Item:
	return ItemRegister.findItem(id)
