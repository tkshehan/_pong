extends Control

func update_scores(scores: Array = [0,0]):
	if GameState.num_of_players == 1:
		$Score/HBoxContainer/LeftLabel.text = 'Level ' + str(scores[1] + 1) 
		$Score/HBoxContainer/RightLabel.text = 'Deaths: ' + str(scores[0])
	else:
		$Score/HBoxContainer/LeftLabel.text = str(scores[0])
		$Score/HBoxContainer/RightLabel.text = str(scores[1])

func game_start():
	update_scores()
	$PauseMenu.game_start()

func game_over(scores: Array):
	if GameState.num_of_players != 1:
		update_scores(scores)
	$PauseMenu.game_over(scores)
