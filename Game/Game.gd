extends Node

var scores = [0,0]

func _ready():
	$World.spawn_ball()
	$HUD.game_start()

func _on_World_goal(side) -> void:
	if side == "left":
		scores[1] += 1
	elif side == "right":
		scores[0] += 1
	if _is_game_over():
		$HUD.game_over(scores)
	$HUD.update_scores(scores)

func _is_game_over():
	if GameState.num_of_players == 1:
		return scores[1] > 9
	else:
		return scores[0] >= 5 or scores[1] >= 5
