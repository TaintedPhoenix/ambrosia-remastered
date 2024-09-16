
class_name ItemReference extends ItemLike

@warning_ignore("shadowed_variable")
func _init(id : String):
	super(id)

func resolve() -> Item:
	return ItemRegister.findItem(id)
