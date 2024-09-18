extends Node2D

@export var itemIds : Dictionary = {}
var items = []
var minRarity : ItemRarity = ItemRarity.UNOBTAINABLE
@onready var originalTexture = $Sprite2D.texture
var highlightTexture 
var opened := false
@export var chestId : String = "0"

func _ready() -> void:
	set_process(false)
	if GameData.openedChests.has(chestId):
		open()
	else: 
		for itemid in itemIds:
			var fi = ItemRegister.findItem(itemid)
			if not Item.isNull(fi) and itemIds[itemid] > 0.0:
				items.append([fi, itemIds[itemid]])
				if ItemRarity.compare(fi.rarity, minRarity) > 0:
					minRarity = fi.rarity
		highlightTexture = make_highlight()
		$Area2D.body_entered.connect(entered)
		$Area2D.body_exited.connect(exited)
	

func _process(_delta: float) -> void:
	if not opened and Input.is_action_just_pressed("interact") and not GameData.openedChests.has(chestId):
		opened = true
		spawnItem()

func spawnItem():
	set_process(false)
	$Area2D.body_entered.disconnect(entered)
	$Area2D.body_exited.disconnect(exited)
	$AnimationPlayer.play("shake")
	await $AnimationPlayer.animation_finished
	open()
	var toSpawn 
	var totalWeight = 0
	for i in items:
		if not GameData.itemsCollected.has(i.id):
			totalWeight += i[1]
	var r = randf()*totalWeight
	for i in items:
		if not GameData.itemsCollected.has(i.id):
			r-=i[1]
			if r <= 0:
				toSpawn = i
	var its = load("res://scenes/collectables/item/item.tscn").instantiate()
	its.name = "ChestItem" + str(chestId)
	its.init(toSpawn)
	its.position = position + Vector2(0, -8)
	get_parent().add_child(its)
	GameData.openChest(chestId)
	

func open() -> void:
	opened = true
	$Sprite2D.texture = load("res://resources/assets/environment/ChestOpen.png")
	$Sprite2D.position = Vector2(0,-12)
	

func entered(body : Node) -> void:
	if not opened and GameData.isPlayer(body):
		$Sprite2D.texture = highlightTexture
		set_process(true)

func exited(body : Node) -> void:
	if not opened and GameData.isPlayer(body):
		$Sprite2D.texture = originalTexture
		set_process(false)

func make_highlight() -> ImageTexture:
	var highlightcolor = minRarity.color
	var original_image = $Sprite2D.texture.get_image()
	var new_image = Image.create(34, 20, false, Image.FORMAT_RGBA8)
	new_image.fill(Color(0,0,0,0))
	new_image.blit_rect(original_image, Rect2(0, 0, 32, 18), Vector2(1, 1))
	for y in range(18):
		for x in range(32):
			var pixel_color = original_image.get_pixel(x,y)
			if pixel_color.a > 0.0:
				for yy in range(-1, 2):
					for xx in range(-1, 2):
						if xx==0 and yy ==0:
							continue
						var nx = x + 1 + xx
						var ny = y + 1 + yy
						if nx >= 0 and nx < 18 and ny >=0 and ny < 18:
							if new_image.get_pixel(nx, ny).a == 0.0:
								new_image.set_pixel(nx, ny, highlightcolor)
	return ImageTexture.create_from_image(new_image)
