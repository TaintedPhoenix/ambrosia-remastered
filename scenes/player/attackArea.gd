extends Area2D

var enemies_hit : Array[Node] = []
var dmg : float = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func hit(body : Node) -> void:
	if not body in enemies_hit:
		if (body.has_method("attacked")):
			body.attacked(dmg)
		elif (body.has_method("death")):
			body.death()
		else:
			body.queue_free()
		enemies_hit.append(body)
		
func setWeapon(item : Weapon) -> void:
	dmg = item.damage
	
