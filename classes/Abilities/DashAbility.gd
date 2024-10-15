
class_name DashAbility extends ActiveAbility

var boost : int

func _init(options : Dictionary = {}):
	options["id"] = "dash"
	options["actions"] = ["_d_move_left", "_d_move_right"]
	super(options)
	boost = options.get("boost") if options.has("boost") else 10


func condition() -> bool:
	print("condition", enabled)
	return enabled
	
	
func equip() -> void:
	enabled = false
	await GameData.delay(2.5)
	enabled = true
	print("ability enabled")

func activate() -> void:
	enabled = false
	print("activated")
	GameData.player.velocity.x = boost * Input.get_axis("move_left", "move_right")
	await GameData.delay(2.0)
	enabled = true
