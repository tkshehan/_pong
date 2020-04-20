extends Popup

func _ready():
	self.connect("about_to_show", self, "_on_popup")
	self.connect("popup_hide", self, "_on_hide")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if !visible:
			self.popup_centered()
		else:
			visible = false

func _on_popup():
	get_tree().paused = true

func _on_hide():
	get_tree().paused = false
