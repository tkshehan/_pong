extends Paddle
class_name Player_Paddle

var PlayerId = "" # P1 or P2

func _ready() -> void:
	pass

func get_direction():
	return Vector2(
		0,
		Input.get_action_strength(PlayerId + "move_down") - Input.get_action_strength(PlayerId + "move_up")
	)

