extends Control

func _ready() -> void:
	get_node("HBoxContainer/SinglePlayer").grab_focus()
	$HBoxContainer/SinglePlayer.connect("pressed", GameState.root_scene, "start_game")
	$HBoxContainer/Quit.connect("pressed", self, "quit_game")
	
func quit_game():
	get_tree().quit()
