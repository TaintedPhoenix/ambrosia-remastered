extends CharacterBody2D

signal player_hit(damage, knockback, attacker)
#Variables for compatibility with player attackstate



#class_name enemy
@export var maxHealth = 20
var health = maxHealth
@export var dmg = 6
@export var def = 0
@export var aggro = 2 #2 = Aggressive, 1 = Neutral (Will only attack once attacked), 0 = Friendly
var enemySpeed = 4
@export var attackRange = 1
const GRAVITY = 30
var JUMPFORCE = -600
@onready var jumpTimer = 0
@export var atkSpeed = 2
@onready var atkTimer = 0
var is_attacked = false
var attacking = false
var faceRight = false
@onready var playerPOS = GameData.player.position
#onready var spriteScale = $Sprite2.scale.x
@onready var positionVarX = position.x
var inRange = false
var playerInRange = false


func _physics_process(_delta):
		playerPOS = GameData.player.position
		
		jumpTimer -= 1
		atkTimer -= 1
		
		if(abs(position.x - playerPOS.x) > 75 and atkTimer < 1):
			if(position.x < playerPOS.x):
				faceRight = true
				velocity.x = enemySpeed*20
			else:
				faceRight = false
				velocity.x = -enemySpeed*20
				
		if ($RayCast2D.is_colliding() and $RayCast2D.get_collider().get_class() != "CharacterBody2D" and is_on_floor()):
			#print($RayCast2D.get_collider())
			velocity.y = JUMPFORCE
			
		if(!faceRight):
			$RayCast2D.scale.x = 1
			$AnimatedSprite.flip_h = true
			#$Sprite2.scale.x = spriteScale
		else:
			$RayCast2D.scale.x = -1
			$AnimatedSprite.flip_h = false
			#$Sprite2.scale.x = -spriteScale
			
			
		#if( $RayCast2D.is_colliding()):
		#	var collider =$RayCast2D.get_collider()
		#	print(collider)
		#	if(collider.get_class().substr(0, 10) == "StaticBody" && jumpTimer < 1):

		velocity.y = velocity.y + GRAVITY
		move_and_slide()
		velocity.x = lerp(velocity.x, 0.0, .1)
var timeSinceLastHit = 0
# All the stuff below was written by Antony so if it breaks dont pester Alex about it
func _on_Area2Datk_body_entered(body):
	
	if GameData.isPlayer(body):
		playerInRange = true
		var pt : NodePath = body.get_path()
		player_hit.connect(get_node(pt).attacked)
		emit_signal("player_hit", dmg, 0, self.get_path())
		player_hit.disconnect(get_node(pt).attacked)
		timeSinceLastHit = 0

func exited(body):
	if GameData.isPlayer(body):
		playerInRange = false

var sprite : Node
@onready var defaultChilds = [$CollisionPolygon2D, $Area2Datk, $RayCast2D]

func _ready():
	set_physics_process(false)
	var kids = self.get_children()
	for i in range(kids.size()):
		if i >= kids.size(): pass
		elif defaultChilds.has(kids[i]):
			kids.pop_at(i)
			i-=1
	sprite = $AnimatedSprite
		
		
var hurtCtick = 0;
var invincible = false

@warning_ignore("unused_parameter")
func attacked(hdmg, knockback := 0):
	if not invincible:
		health -= hdmg
		if health <= 0:
			health = 0
			queue_free()
		elif health > maxHealth:
			health = maxHealth
		if hdmg > 0:
			invincible = true
			hurtAnim(hurtCtick)
		
func hurtAnimP():
	hurtCtick += 1
	hurtAnim(hurtCtick)
	
func hurtAnim(tick):
	var timeri
	if tick == 0:
		invincible = true
		timeri = Timer.new()
		timeri.name = "timer1"
		self.add_child(timeri)
		$timer1.timeout.connect(hurtAnimP)
	if tick > 2:
		sprite.modulate = Color(1, 1, 1, 1)
		invincible = false
		hurtCtick = 0
		$timer1.stop()
		$timer1.timeout.disconnect(hurtAnimP)
	else:
		$timer1.wait_time = 0.25
		if tick%2 == 0:
			sprite.modulate = Color(255, 0.5, 0.5, 1)
		else:
			sprite.modulate = Color(1, 1, 1, 1)
		$timer1.start()
		
func _process(delta):
	timeSinceLastHit += delta
	if playerInRange and timeSinceLastHit > 1.25:
		if $Area2Datk.overlaps_body(GameData.player):
			var pt : NodePath = GameData.player.get_path()
			player_hit.connect(get_node(pt).attacked)
			emit_signal("player_hit", dmg, 0, self.get_path())
			player_hit.disconnect(get_node(pt).attacked)
			timeSinceLastHit = 0
