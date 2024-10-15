
class_name DashAbility extends ActiveAbility

var boost : int

func _init(options : Dictionary = {}):
	options["id"] = "dash"
	options["actions"] = ["move_left", "move_right"]
	super(options)
	boost = options.get("boost") if options.has("boost") else 10


func condition() -> bool:
	if not enabled: return false
	var t = Timer.new()
	t.wait_time = 0.010
	t.start()
	await t.timeout
	return Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")
	
func equip() -> void:
	enabled = false

func activate() -> void:
	enabled = false
	GameData.player.velocity.x = boost * Input.get_axis("move_left", "move_right")
	var t = Timer.new()
	t.wait_time = 2.0
	t.start()
	await t.timeout
	enabled = true
