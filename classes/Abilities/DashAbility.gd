
class_name DashAbility extends ActiveAbility

var boost : float
var time: float
var active : bool = false
var airdash : bool = false
var cooldown : float

func _init(options : Dictionary = {}):
	options["id"] = "dash"
	options["actions"] = ["_d_move_left", "_d_move_right"]
	super(options)
	boost = options.get("boost") if options.has("boost") else 1400
	time = options.get("duration") if options.has("duration") else 0.3
	cooldown = options.get("cooldown") if options.has("cooldown") else 0.2


func condition() -> bool:
	return enabled and not airdash
	
	
func equip() -> void:
	enabled = false
	await GameData.delay(cooldown)
	enabled = true
	
	
func physics_process(delta):
	if airdash and GameData.player.is_on_floor():
		airdash = false
	if not active: return
	if abs(GameData.player.velocity.x) <= GameData.player.move_speed or GameData.player.is_on_wall():
		active = false
		GameData.player.set_physics_process(true)
		await GameData.delay(cooldown)
		enabled = true
	else:
		if not GameData.player.is_on_floor():
			GameData.player.velocity.y += GameData.player.get_gravity().y * 0.5 * delta
		GameData.player.velocity.x = move_toward(GameData.player.velocity.x, 0, delta*((boost - GameData.player.move_speed)/time))
		GameData.player.move_and_slide()
		

func activate() -> void:
	enabled = false
	GameData.player.set_physics_process(false)
	GameData.player.velocity.y = 0
	GameData.player.velocity.x = boost * Input.get_axis("move_left", "move_right")
	airdash = not GameData.player.is_on_floor()
	active=true
