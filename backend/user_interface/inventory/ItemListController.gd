extends VBoxContainer

signal clearTooltips

const ItemBlock = preload("res://backend/user_interface/inventory/ItemBlock.tscn")

var display = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	resolveItems();
	sortItems();
	displayItems();
	GameData.itemUnequipped.connect(itemUnequipped)
	$"../../Control/Search".connect("text_changed", search)

func clearDisplay() -> void:
	var kids = self.get_children()
	emit_signal("clearTooltips")
	for kid in kids:
		if kid.has_signal("equip"):
			kid.disconnect("equip", itemEquipped)
		remove_child(kid)

func search(q) -> void:
	var query = q.to_lower()
	if (len(query) > 0):
		var output = []
		for i in range (0, len(GameData.inventory)):
			var item = resolveItem(GameData.inventory[i])
			if item.displayName.to_lower().find(query) != -1 or item.rarity.name.to_lower() == query:
				output.append(item)
		display = output
		sortItems()
		displayItems()
	else:
		resolveItems()
		sortItems()
		displayItems()

func resolveItems() -> void:
	var output : Array[Item] = []
	for i in range(0, len(GameData.inventory)):
		var item
		if GameData.inventory[i] is ItemReference:
			item = GameData.inventory[i].resolve()
		else:
			item = GameData.inventory[i]
		output.append(item)
	display = output

func resolveItem(item : ItemLike) -> Item:
	if item is ItemReference:
		return item.resolve()
	else:
		return item

func sortItems() -> void:
	var output = []
	if len(display) > 0:
		var s = len(display)
		for i in range(0, len(display)):
			output.append(display[i])
			s = i
		for x in range(s+1, len(display)):
			var pos = len(output)
			for y in range(0, len(output)):
				var c = compareItems(output[y], display[x])
				if (c < 0 && y < pos):
					pos = y;
				elif (c == 0):
					pos = y+1
			output.insert(pos, display[x]);
		display = output;
	else:
		display = []

func redrawItems() -> void:
	var txt = $"../../Control/Search".text
	search(txt)

func displayItems() -> void:
	clearDisplay()
	for i in range(0, len(display)):
		var itembl = ItemBlock.instantiate();
		itembl.init(display[i], i);
		itembl.equip.connect(itemEquipped)
		self.add_child(itembl);
	#if len(display) == len(GameData.inventory):
		#var itembl = ItemBlock.instantiate();
		#itembl.init(Item.new("null", "res://resources/assets/none.png", "null", ItemRarity.UNOBTAINABLE, ""), len(display)+1);
		#self.add_child(itembl);

func itemEquipped(item : Item) -> void:
	GameData.equipItem(item)
	#await GameData.itemEquipped
	redrawItems()
	
func itemUnequipped(_category : String) -> void:
	redrawItems()

func compareRarity(a : ItemRarity, b : ItemRarity) -> int:
	if (a.value > b.value): return 1;
	elif (b.value > a.value): return -1;
	elif (a.value == b.value): return 0;
	else: return 0

func compareItems(a : Item, b : Item) -> int:
	if (compareRarity(a.rarity, b.rarity) > 0 ):
		return 1;
	elif (compareRarity(a.rarity, b.rarity) < 0):
		return -1;
	else:
		if (a is Weapon && b is Weapon):
			if (a.damage > b.damage): return 1;
			elif (b.damage > a.damage): return -1;
			else:
				if (a.displayName.to_lower() < b.displayName.to_lower()): return 1;
				elif (a.displayName.to_lower() > b.displayName.to_lower()): return -1;
				else: return 0;
		elif a is Weapon: return 1;
		elif b is Weapon: return -1;
		else:
			if (a.displayName.to_lower() < b.displayName.to_lower()): return 1;
			elif (a.displayName.to_lower() > b.displayName.to_lower()): return -1;
			else: return 0;
