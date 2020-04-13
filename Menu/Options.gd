extends Control
signal closed


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$HBoxContainer/VBoxContainer/Back.grab_focus()



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Back_pressed():
	queue_free()
	emit_signal("closed")


func _on_Controls_pressed():
	pass # Replace with function body.


func _on_Audio_pressed():
	pass # Replace with function body.


func _on_Video_pressed():
	pass # Replace with function body.
