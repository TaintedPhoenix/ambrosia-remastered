extends Node2D
signal done

@onready var player = GameData.player
@onready var eqw = GameData.equippedWeapon
const spriteSpeed = 2.5

func attack() -> void:
	visible=true
	$Sprite2D.texture = eqw.get_sprite()
	$Sprite2D.scale = eqw.size * Vector2(2.5, 2.5)
	$"../AnimatedSprite2D".speed_scale = 2.5 * eqw.speed
	$AnimationPlayer.speed_scale = 6 * 2.5 * eqw.speed
	var abox = load("res://scenes/weapons/slash/attackArea.tscn").instantiate()
	abox.setWeapon(eqw)
	$"../AnimatedSprite2D".play("attack")
	if $"../AnimatedSprite2D".flip_h:
		abox.scale = Vector2(-1, 1) * eqw.size
		$AnimationPlayer.play("sword_attack_left_directional")
	else:
		abox.scale = Vector2(1, 1) * eqw.size
		$AnimationPlayer.play("sword_attack_right")
	add_child(abox)
	await $AnimationPlayer.animation_finished
	abox.queue_free()
	done.emit()
