
class_name DoubleJumpAbility extends ActiveAbility

var airFrames : int = 0

func _init() -> void:
	super({
		"id" : "doublejump",
		"actions" : ["move_up"]
	})


func condition() -> bool:
	return enabled and !GameData.player.is_on_floor() and airFrames >= 2
	
func equip() -> void:
	enabled = false

func process(_delta) -> void:
	if GameData.player.is_on_floor():
		enabled = true
		airFrames = 0
	else:
		airFrames += 1

func activate() -> void:
	enabled = false
	if abs(GameData.player.velocity.y) < 200:
		var x = GameData.player.velocity.y + 200
		GameData.player.velocity.y = GameData.player.jump_velocity * ((-(pow(x, 2)) + (400 * x))*(3.0/400000)+1)
	else:
		GameData.player.velocity.y = GameData.player.jump_velocity
