

class_name UiElement

var name : String
var elementPath : String

@warning_ignore("shadowed_variable")
func _init(name : String, elementPath : String):
	self.name = name
	self.elementPath = elementPath
	
func instantiate():
	return load(elementPath).instantiate()
