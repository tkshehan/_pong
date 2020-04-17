extends Node2D

var current_ball
const Center = Vector2(256,160)

onready var ball = preload("res://Game/Ball.tscn")
var difficulty = 0

func _ready() -> void:
	spawn_ball()

func _on_Net_L_goal() -> void:
	difficulty += 1
	spawn_ball()

func _on_Net_R_goal() -> void:
	difficulty -= 1
	spawn_ball()

func spawn_ball() -> void:
	get_node("Score/HBoxContainer/Label").set_text("Difficulty: " + str(difficulty))
	$AI_Player/Paddle.max_speed = difficulty * 50
	
	current_ball = ball.instance()
	current_ball.position = Center
	var rand = 25 * (randi()%4 + 1)
	current_ball.velocity = Vector2(
		-100 if randi() % 2 else 100,
		-rand if randi() % 2 else rand
	)

	call_deferred("add_child", current_ball)
	$AI_Player/Paddle.set_target(current_ball)
	
	
