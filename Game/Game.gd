extends Node

var scores = [0,0]

func _ready():
	$World.spawn_ball()
	$HUD/PauseMenu.popup_centered()

func _on_World_goal(side) -> void:
	if side == "left":
		scores[0] += 1
		$HUD/Score/HBoxContainer/LeftLabel.text = str(scores[0])
	if side == "right":
		scores[1] += 1
		$HUD/Score/HBoxContainer/RightLabel.text = str(scores[1])
