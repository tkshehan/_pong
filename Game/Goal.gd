extends Area2D

func _ready() -> void:
	self.connect("body_entered", self, "on_body_entered")


func on_body_entered(body):
	pass
