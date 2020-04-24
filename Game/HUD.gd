extends Control

func update_scores(scores):
	if GameState.num_of_players == 1:
		$Score/HBoxContainer/LeftLabel.text = 'Level ' + str(scores[0] + 1) 
		$Score/HBoxContainer/RightLabel.text = 'Deaths: ' + str(scores[1])
	else:
		$Score/HBoxContainer/LeftLabel.text = str(scores[1])
		$Score/HBoxContainer/RightLabel.text = str(scores[0])
