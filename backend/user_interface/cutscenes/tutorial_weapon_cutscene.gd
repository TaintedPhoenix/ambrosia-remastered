extends CanvasLayer

signal cutscene_finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("interact") or Input.is_action_just_pressed("move_up") or Input.is_action_just_pressed("inventory") or Input.is_action_just_pressed("pause"):
		cutscene_finished.emit()
