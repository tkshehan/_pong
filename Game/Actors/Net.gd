extends Area2D

signal goal

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var _err = self.connect("body_entered", self, "on_body_entered")

func on_body_entered(body):
	body.in_net = true
	emit_signal("goal")
	
