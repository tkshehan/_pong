extends Popup

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if !visible:
			self.popup_centered()
			get_tree().paused = true
			
		else:
			visible = false
			get_tree().paused = false
