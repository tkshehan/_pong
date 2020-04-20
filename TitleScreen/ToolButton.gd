extends ToolButton

func _on_ToolButton_focus_entered() -> void:
	$Sprite.visible = true


func _on_ToolButton_focus_exited() -> void:
	$Sprite.visible = false
