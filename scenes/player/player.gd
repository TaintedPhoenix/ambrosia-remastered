extends CharacterBody2D


const SPEED = 350.0
const JUMP_VELOCITY = -600.0
const spriteSpeed = 2.5
var maxHealth = 100.0
var health = maxHealth

var state = "idle"

@warning_ignore("unused_parameter")
func attacked(dmg : float, _knockback : float, attacker : Node):
	health -= dmg
	if health <= 0:
		Loader.resetScene()

func _ready() -> void:
	GameData.setPlayer(self)

@warning_ignore("unused_parameter")
func _process(delta : float):
	if state == "idle":
		if Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
			state = "move"
		elif Input.is_action_just_pressed("primary_attack") or Input.is_action_just_pressed("secondary_attack"):
			state = "attack"
			attackState()
		else:
			$AnimatedSprite2D.play("idle")
			$AnimatedSprite2D.offset = Vector2(0, 0)
	elif state == "move":
		$AnimatedSprite2D.play("run")
		$AnimatedSprite2D.offset = Vector2(-5, 0)
	elif state == "attack":
		pass
		
func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if state == "move" or state == "attack":
		if Input.is_action_just_pressed("move_up") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("move_left", "move_right")
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		
		if state != "attack":
			if direction==-1:
				$AnimatedSprite2D.flip_h = true
			elif direction==1:
				$AnimatedSprite2D.flip_h = false

			if Input.is_action_just_pressed("primary_attack") or Input.is_action_just_pressed("secondary_attack"):
				state="attack"
				attackState()
				return
			elif velocity.x != 0 or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or velocity.y < 0:
				$AnimatedSprite2D.play("run")
				if not $AnimatedSprite2D.flip_h:
					$AnimatedSprite2D.position = Vector2(0, -20)
				elif $AnimatedSprite2D.flip_h: 
					$AnimatedSprite2D.position = Vector2(11,-20)
			else:
				state = "idle"
				$AnimatedSprite2D.play("idle")
				if $AnimatedSprite2D.flip_h:
					$AnimatedSprite2D.position = Vector2(0, -20)
				else:
					$AnimatedSprite2D.position = Vector2(0,-20)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
func attackState():
	var eq = GameData.equippedWeapon
	if eq == null or not eq is Weapon:
		if Input.is_action_pressed("move_up") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			state = "move"
			moveState()
		else:
			state = "idle"
		return
	set_process(false)
	var eqw : Weapon = eq
	var ws : Node = load(eqw.attackScenePath).instantiate()
	add_child(ws)
	if eqw.auto:
		while (Input.is_action_pressed("primary_attack") or Input.is_action_pressed("secondary_attack")) and GameData.equippedWeapon == eqw:
			ws.attack()
			await ws.done
			$AnimatedSprite2D.stop()
			var direction := Input.get_axis("move_left", "move_right")
			if direction==-1:
				$AnimatedSprite2D.flip_h = true
			elif direction==1:
				$AnimatedSprite2D.flip_h = false
	else:
		ws.attack()
		await ws.done
	ws.queue_free()
	$AnimatedSprite2D.speed_scale = spriteSpeed
	set_process(true)
	$AnimatedSprite2D.stop()
	if Input.is_action_just_pressed("primary_attack") or Input.is_action_just_pressed("secondary_attack"):
		var direction := Input.get_axis("move_left", "move_right")
		if direction==-1:
			$AnimatedSprite2D.flip_h = true
		elif direction==1:
			$AnimatedSprite2D.flip_h = false
		attackState()
	elif Input.is_action_pressed("move_up") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state = "move"
		moveState()
	else:
		state = "idle"
		
func moveState():
	pass
