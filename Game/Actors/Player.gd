extends Paddle

func _ready() -> void:
	pass

func get_direction():
	return Vector2(
		0,
		Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	)

