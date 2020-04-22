extends Control

func _ready() -> void:
	get_node("HBoxContainer/SinglePlayer").grab_focus()
	$HBoxContainer/SinglePlayer.connect("pressed", GameState.root_scene, "_on_start_1p")
	$HBoxContainer/TwoPlayer.connect("pressed", GameState.root_scene, "_on_start_2p")
	$HBoxContainer/Demo.connect("pressed", GameState.root_scene, "_on_start_0p")
	$HBoxContainer/Quit.connect("pressed", self, "quit_game")
	
func quit_game():
	get_tree().quit()
