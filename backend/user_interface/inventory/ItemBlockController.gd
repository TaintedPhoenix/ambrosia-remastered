extends Panel
signal equip(item : Item)

const ToolTip = preload("res://backend/user_interface/inventory/Tooltip.tscn")

var hovered = false
var item : Item
var id : int
var tooltip 



func _ready():
	
	if item is Weapon:
		$Button.disabled = false
		$Button.pressed.connect(clicked)
	tooltip = ToolTip.instantiate()
	tooltip.name = "Tooltip" + str(id) 
	get_node("../../../../../../Tooltips").add_child(tooltip)
	get_node("ItemIcon").texture = item.get_sprite()
	get_node("ItemName").text = item.displayName
	get_node("ItemName").set("theme_override_colors/font_color", item.rarity.color)
	get_node(String(tooltip.get_path()) + "/TooltipName").text = item.displayName
	get_node(String(tooltip.get_path()) + "/TooltipName").set("theme_override_colors/font_color", item.rarity.color)
	get_node(String(tooltip.get_path()) + "/TooltipLore").text = item.description
	if item is Weapon:
		get_node(String(tooltip.get_path()) + "/TooltipDamage").text  = str(item.damage)
		get_node(String(tooltip.get_path()) + "/TooltipDamage").set("theme_override_colors/font_color", item.rarity.color)
		get_node(String(tooltip.get_path()) + "/TooltipCount").visible = false
		get_node("ItemCount").visible = false
	#elif item_data.has("use"):
		#get_node(String(tooltip.get_path()) + "/TooltipDamage").visible = false
		#get_node(String(tooltip.get_path()) + "/TooltipDamageLabel").visible = false
		#get_node(String(tooltip.get_path()) + "/TooltipCount").text = str(item_data.count)
		#get_node("ItemCount").text = str(item_data.count)
	else:
		get_node(String(tooltip.get_path()) + "/TooltipDamage").visible = false
		get_node(String(tooltip.get_path()) + "/TooltipDamageLabel").visible = false
		get_node(String(tooltip.get_path()) + "/TooltipCount").visible = false
		get_node("ItemCount").visible = false
	get_node("..").connect("clearTooltips", clear_tooltip)
	
	
		
		

func clear_tooltip():
	tooltip.visible = false

func hover_start():
	hovered = true
	set_process(true)
	tooltip.visible = true

func hover_stop():
	if hovered:
		tooltip.visible = false
		hovered = false
		set_process(false)

func _process(_delta):
	if hovered:
		var prefPos = get_viewport().get_mouse_position() + Vector2(10, 20)
		var boxBottomRight = tooltip.size + get_viewport().get_mouse_position() + Vector2(10, 20)
		if boxBottomRight.y > get_viewport_rect().size.y:
			prefPos.y = get_viewport_rect().size.y - tooltip.size.y
		tooltip.position = prefPos

@warning_ignore("shadowed_variable")
func init(item : Item, id : int) -> void:
	self.item = item
	self.id = id
	
func clicked():
	equip.emit(item)
#func compileAnimatedSprite(spritename):
	#var texture = AnimatedTexture.new()
	#var frames = DirAccess.get_files_at("res://Assets/Sprites/Items/Animated/" + spritename);
	#var toRemove = []
	#for i in range (0, len(frames)):
		#if not frames[i].rfind(".png") == len(frames[i]) - 4:
			#toRemove.append(frames[i]);
			#
	#for i in toRemove:
		#frames.remove_at(frames.find(i))
			#
	#texture.set_frames(len(frames))
	#for i in range (0, len(frames)):
		#texture.set_frame_texture(i, load("res://Assets/Sprites/Items/Animated/" + spritename + "/" + frames[i]))
		#texture.set_frame_duration(i, 0.125)
	#texture.set_pause(false)
	#return texture
