extends Paddle
class_name PlayerPaddle

var player_ID = "" # P1 or P2

func _ready() -> void:
	pass

func get_direction():
	return Vector2(
		0,
		Input.get_action_strength(player_ID + "move_down") - Input.get_action_strength(player_ID + "move_up")
	)

