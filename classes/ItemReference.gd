
class_name ItemReference extends ItemLike

func _init(id : String):
	super(id)

func resolve() -> Item:
	return ItemRegister.findItem(id)
