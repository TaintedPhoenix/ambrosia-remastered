extends Node

signal screen_resize

var HUD : Node
var state = "other" #"other" "game" "inventory" "pause" "hidden"

var screenScale := Vector2.ONE

var inventoryElement : UiElement = UiElement.new("inventory", "res://backend/user_interface/inventory/inventory.tscn")
var pauseElement : UiElement = UiElement.new("pause", "res://backend/user_interface/pause/pause.tscn")
var gameHudElement: UiElement = UiElement.new("gamehud", "res://backend/user_interface/gamehud/gamehud.tscn")


var activeElements : Array[UiElement] = []

func _ready():
	HUD = Node.new()
	HUD.name = "HUD"
	set_process_mode(Node.PROCESS_MODE_ALWAYS)
	HUD.set_process_mode(Node.PROCESS_MODE_ALWAYS)
	add_child(HUD)
	
	screenScale = Vector2(get_viewport().get_visible_rect().size.x / 1920, get_viewport().get_visible_rect().size.y / 1080)
	get_viewport().size_changed.connect(windowResized)
	Loader.main_scene_changed.connect(scene_changed)
	
func windowResized():
	screenScale = Vector2(get_viewport().get_visible_rect().size.x / 1920, get_viewport().get_visible_rect().size.y / 1080)
	screen_resize.emit()
	
func _process(_delta):
	if Input.is_action_just_pressed("pause") :
		if state == "game":
			state = "pause"
			get_tree().paused = true
			hideAllElements()
			showElement(pauseElement)
		elif state == "pause":
			hideElement(pauseElement)
			state = "game"
			showElement(gameHudElement)
			get_tree().paused = false
		elif state == "inventory":
			hideElement(inventoryElement)
			get_tree().paused = false
			state = "game"
	elif Input.is_action_just_pressed("inventory"):
		if state == "game":
			state = "inventory"
			get_tree().paused = true
			showElement(inventoryElement)
		elif state == "inventory":
			hideElement(inventoryElement)
			get_tree().paused = false
			state = "game"
	
func playCutscene(cutscene : String):
	state = "pause"
	get_tree().paused = true
	hideAllElements()
	var cs = load("res://backend/user_interface/cutscenes/" + cutscene + ".tscn")
	if cs == null: return
	cs = cs.instantiate()
	cs.name = cutscene
	HUD.add_child(cs)
	await cs.cutscene_finished
	cs.queue_free()
	state = "game"
	showElement(gameHudElement)
	get_tree().paused = false
	
func scene_changed():
	hideAllElements()
	get_tree().paused = false
	if state == "game":
		showElement(gameHudElement)
	elif state == "other":
		pass

func showElement(element : UiElement):
	if not element in activeElements:
		var x = element.instantiate()
		x.name = element.name
		HUD.add_child(x)
		activeElements.append(element)
		
func unpause():
	if state == "pause" or get_tree().paused:
		hideElement(pauseElement)
		state = "game"
		showElement(gameHudElement)
		get_tree().paused = false
		
func hideElement(element : UiElement):
	if element in activeElements:
		for kid in HUD.get_children():
			if kid.name == element.name:
				HUD.remove_child(kid)
				activeElements.erase(element)
	
func hideAllElements():
	for el in activeElements:
		hideElement(el)
		
	
