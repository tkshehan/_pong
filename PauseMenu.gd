extends Popup
var game_is_over = false

func _ready():
	var _err = self.connect("about_to_show", self, "_on_popup")
	_err = self.connect("popup_hide", self, "_on_hide")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if !visible:
			$Label.text = 'Paused\n\nPress Space'
			self.popup_centered()
		else:
			visible = false
			if game_is_over:
				GameState.reset()

func _on_popup():
	get_tree().paused = true

func _on_hide():
	get_tree().paused = false

func game_start():
	if GameState.num_of_players == 1:
		$Label.text = 'Get Past Level 10\n\nPress Space To Start'
	else:
		$Label.text = 'First To 5\n\nPress Space To Start'
	self.popup_centered()
	
func game_over(scores):
	if GameState.num_of_players == 1:
		$Label.text = "Congratulations\nYou Died " + str(scores[0]) + " times."
	else:
		var winner = "Player 1" if scores[0] >= 5 else "Player 2"
		$Label.text = winner + " Wins."
		
	game_is_over = true
	self.popup_centered()
