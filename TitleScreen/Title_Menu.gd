extends Control

func _ready() -> void:
	get_node("HBoxContainer/SinglePlayer").grab_focus()
	var _err = $HBoxContainer/SinglePlayer.connect("pressed", GameState.root_scene, "_on_start_1p")
	_err = $HBoxContainer/TwoPlayer.connect("pressed", GameState.root_scene, "_on_start_2p")
	_err = $HBoxContainer/Demo.connect("pressed", GameState.root_scene, "_on_start_0p")
	_err = $HBoxContainer/Quit.connect("pressed", self, "quit_game")
	
func quit_game():
	get_tree().quit()
