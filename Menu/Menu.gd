extends Node

signal start_game
signal quit_game


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/Start.grab_focus()


func _on_Start_pressed():
	emit_signal("start_game")


func _on_Options_pressed():
	var OptionsMenu = load("res://Menu/Options.tscn").instance()
	add_child(OptionsMenu)
	OptionsMenu.connect("closed", self, "on_options_closed")

func on_options_closed():
	$VBoxContainer/Start.grab_focus()


func _on_Quit_pressed():
	emit_signal("quit_game")
