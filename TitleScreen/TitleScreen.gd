extends Control

onready var Menu = load("res://TitleScreen/Title_Menu.tscn").instance()


func _on_Press_Start_tree_exited() -> void:
	call_deferred("add_child", Menu)
