extends Node2D

var current_ball
const Center = Vector2(256,160)

onready var ball = preload("res://Game/Ball.tscn")
var difficulty = 1

func _ready() -> void:
	init()
	
	spawn_ball()
	$PauseMenu.popup_centered()
	get_tree().paused = true
	

func _on_Net_L_goal() -> void:
	difficulty += 1
	spawn_ball()

func _on_Net_R_goal() -> void:
	difficulty -= 1
	spawn_ball()

func spawn_ball() -> void:
	get_node("Score/HBoxContainer/Label").set_text("Difficulty: " + str(difficulty))
	$Paddle_L.Acceleration = 0.05
	$Paddle_L.max_speed = 100 + (50 * difficulty)
	
	current_ball = ball.instance()
	current_ball.position = Center
	var rand = 25 * (randi()%4 + 1)
	current_ball.velocity = Vector2(
		-100 if randi() % 2 else 100,
		-rand if randi() % 2 else rand
	)

	call_deferred("add_child", current_ball)
	$Paddle_L.set_target(current_ball)
	
	
func init():
	if GameState.num_of_players == 1:
		$Paddle_L.set_script(preload("res://Game/Actors/AI_Player.gd"))
		$Paddle_R.set_script(preload("res://Game/Actors/Player.gd"))
