extends Node2D

@warning_ignore("unused_signal")
signal inrange(item : Item)

@export var itemId : String = "sword"
var item  = null
var highlight : Texture2D

var isChest := false

func init(i : Item):
	isChest = true
	item = i

func _ready() -> void:
	set_process(false)
	if item == null:
		item = ItemRegister.findItem(itemId)
	if item != null and item is Item and item.rarity.value != ItemRarity.UNOBTAINABLE.value:
		if item.id in GameData.itemsCollected:
			queue_free()
		$Sprite2D.texture = item.get_sprite()
		highlight = make_highlight(item.get_sprite())
		$Area2D.body_entered.connect(entered)
		$Area2D.body_exited.connect(exited)
		$AnimationPlayer.play("hover")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact"):
		if not isChest:
			GameData.collectItem(item)
		else:
			GameData.saveItem(item)
		queue_free()
	
func entered(body : Node) -> void:
	if GameData.isPlayer(body):
		$Sprite2D.texture = highlight
		set_process(true)

func exited(body : Node) -> void:
	if GameData.isPlayer(body):
		$Sprite2D.texture = item.get_sprite()
		set_process(false)

func make_highlight(sprite : Texture2D) -> ImageTexture:
	var highlightcolor = item.highlightColor
	if highlightcolor.a < 1.0:
		highlightcolor = item.rarity.color
	var original_image = sprite.get_image()
	var new_image = Image.create(18, 18, false, Image.FORMAT_RGBA8)
	new_image.fill(Color(0,0,0,0))
	new_image.blit_rect(original_image, Rect2(0, 0, 16, 16), Vector2(1, 1))
	for y in range(16):
		for x in range(16):
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
