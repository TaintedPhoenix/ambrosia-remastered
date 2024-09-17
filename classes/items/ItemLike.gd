
class_name ItemLike

var id : String

@warning_ignore("shadowed_variable")
func _init(options : Dictionary = {}) -> void:
	id = options.get("id") if options.has("id") else "null"
