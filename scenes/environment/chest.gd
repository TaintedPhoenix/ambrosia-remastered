extends Node2D

@export var itemIds : Array[String] = []
var items : Array[Item] = []
var minRarity : ItemRarity = ItemRarity.UNOBTAINABLE
@onready var originalTexture = $Sprite2D.texture
var highlightTexture 
var opened := false
@export var chestId : int

func _ready() -> void:
	set_process(false)
	for itemid in itemIds:
		var fi = ItemRegister.findItem(itemid)
		if not Item.isNull(fi):
			items.append(fi)
			if ItemRarity.compare(fi.rarity, minRarity) > 0:
				minRarity = fi.rarity
	highlightTexture = make_highlight()
	$Area2D.body_entered.connect()
	

func _process(_delta: float) -> void:
	if not opened and Input.is_action_just_pressed("interact"):
		spawnItem()

func spawnItem():
	open()

func open() -> void:
	opened = true
	$Sprite2D.texture = load("res://resources/assets/environment/ChestOpen.png")
	

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
	var original_image = $Sprite2D.texture
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
