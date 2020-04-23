extends Node

var current_ball
const Center = Vector2(256,160)
signal goal(side)

onready var ball = preload("res://Game/Ball.tscn")

func _ready() -> void:
	if GameState.num_of_players == 0:
		$Paddle_L.set_script(AIPaddle)
		$Paddle_R.set_script(AIPaddle)
		
	if GameState.num_of_players == 1:
		$Paddle_L.set_script(AIPaddle)
		$Paddle_R.set_script(PlayerPaddle)

	if GameState.num_of_players == 2:
		$Paddle_L.set_script(PlayerPaddle)
		$Paddle_R.set_script(PlayerPaddle)
		$Paddle_L.player_ID = "P1"
		$Paddle_R.player_ID = "P2"
		
	$Paddle_L.set_grip_position_offset(17)

func _on_Net_L_goal() -> void:
	emit_signal("goal", "left")
	spawn_ball()

func _on_Net_R_goal() -> void:
	emit_signal("goal", "right")
	spawn_ball()

func spawn_ball() -> void:
	current_ball = ball.instance()
	current_ball.position = Center
	var rand = 25 * (randi()%4 + 1)
	current_ball.velocity = Vector2(
		-225 if randi() % 2 else 225,
		-rand if randi() % 2 else rand
	)
	call_deferred("add_child", current_ball)
	if $Paddle_L is AIPaddle:
		update_ai($Paddle_L)
	if $Paddle_R is AIPaddle:
		update_ai($Paddle_R)

func update_ai(paddle):
	paddle.set_target(current_ball)
