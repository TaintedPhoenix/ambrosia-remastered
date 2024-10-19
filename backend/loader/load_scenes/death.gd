extends Node2D

var cooldown := 6.0

func _ready() -> void:
	get_tree().paused = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if cooldown >= 0:
		cooldown -= delta
	else:
		if cooldown >= -5:
			cooldown -= delta
			$Continue.modulate = Color(1, 1, 1, cooldown/-5.0)
			$actionIndicator.modulate = Color(1, 1, 1, cooldown/-5.0)
		if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("move_up"):
			Loader.resetLevel()
			get_tree().paused = false
			set_process(false)
