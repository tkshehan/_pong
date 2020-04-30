extends Control

func _ready() -> void:
	$AnimationPlayer.play("CurtainOpen")

func _on_AnimationPlayer_animation_finished(_anim_name: String) -> void:
	queue_free()
