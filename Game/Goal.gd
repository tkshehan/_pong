extends Area2D

func _ready() -> void:
	var _err = self.connect("body_entered", self, "on_body_entered")

func on_body_entered(_body):
	pass
