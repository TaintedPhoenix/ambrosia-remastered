extends Node2D

@export var itemIds : Dictionary = {}
var items = []
var minRarity : ItemRarity = ItemRarity.MYTHICAL
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
				if ItemRarity.compare(fi.rarity, minRarity) < 0:
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
	$Sprite2D.texture = originalTexture
	$Sprite2D.position = Vector2(0,0)
	$Area2D.body_entered.disconnect(entered)
	$Area2D.body_exited.disconnect(exited)
	$AnimationPlayer.play("shake")
	await $AnimationPlayer.animation_finished
	$actionIndicator.hidden()
	open()
	var toSpawn = null
	var totalWeight = 0
	for i in items:
		if not GameData.itemsCollected.has(i[0].id):
			totalWeight += i[1]
	var r = randf()*totalWeight
	for i in items:
		if not GameData.itemsCollected.has(i[0].id):
			r-=i[1]
			if r <= 0 and toSpawn == null :
				toSpawn = i[0]
				break
	var its = load("res://scenes/collectables/item/item.tscn").instantiate()
	its.name = "ChestItem" + str(chestId)
	its.init(toSpawn)
	its.position = position + Vector2(0, -8)
	get_parent().add_child(its)
	GameData.openedChests.append(chestId)
	

func open() -> void:
	opened = true
	$Sprite2D.texture = load("res://resources/assets/environment/ChestOpen.png")
	$Sprite2D.position = Vector2(0,-12)
	

func entered(body : Node) -> void:
	if not opened and GameData.isPlayer(body):
		$actionIndicator.shown()
		$Sprite2D.texture = highlightTexture
		$Sprite2D.position = Vector2(0,-4.5)
		set_process(true)

func exited(body : Node) -> void:
	if not opened and GameData.isPlayer(body):
		$actionIndicator.hidden()
		$Sprite2D.texture = originalTexture
		$Sprite2D.position = Vector2(0,0)
		set_process(false)

func make_highlight() -> ImageTexture:
	var highlightcolor = minRarity.color

	var original_image = originalTexture.get_image()

# Create a new image that is 36x20, with transparent background
	var new_image = Image.create(36, 20, false, Image.FORMAT_RGBA8)
	new_image.fill(Color(0, 0, 0, 0))

# Blit the original image into the center (starting from 2, 2 to account for the 2-pixel border)
	new_image.blit_rect(original_image, Rect2(0, 0, 32, 18), Vector2(2, 2))

# Iterate over the original texture pixels to find opaque pixels
	for y in range(18):
		for x in range(32):
			var pixel_color = original_image.get_pixel(x, y)

# If the pixel is opaque (non-transparent)
			if pixel_color.a > 0.0:
# Check surrounding pixels (2-pixel radius)
				for yy in range(-2, 3):  # Range of -2 to 2 for a 2-pixel outline
					for xx in range(-2, 3):
# Ignore the center pixel (the original opaque pixel)
						if xx == 0 and yy == 0:
							continue

						var nx = x + 2 + xx
						var ny = y + 2 + yy
						if nx >= 0 and nx < 36 and ny >= 0 and ny < 20:
						# Prevent outlining below the original sprite, but allow on sides
							if ny < 20 or (yy < 0 and ny < 20):  
								if new_image.get_pixel(nx, ny).a == 0.0:
									new_image.set_pixel(nx, ny, highlightcolor)
	return ImageTexture.create_from_image(new_image)
