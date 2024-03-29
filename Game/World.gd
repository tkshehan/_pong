extends Node

var current_ball
const Center = Vector2(256,160)
signal goal(side)
var last_goal = "none"

onready var ball = preload("res://Game/Ball.tscn")

func _ready() -> void:
	if GameState.num_of_players == 0:
		$Paddle_L.set_script(AIPaddle)
		$Paddle_L.difficulty = 6
		$Paddle_R.set_script(AIPaddle)
		$Paddle_R.difficulty = 6
		
	if GameState.num_of_players == 1:
		$Paddle_L.set_script(AIPaddle)
		$Paddle_R.set_script(PlayerPaddle)

	if GameState.num_of_players == 2:
		$Paddle_L.set_script(PlayerPaddle)
		$Paddle_L.player_ID = "P1"
		$Paddle_R.set_script(PlayerPaddle)
		$Paddle_R.player_ID = "P2"

func _on_Net_L_goal() -> void:
	emit_signal("goal", "left")
	last_goal = "left"
	spawn_ball()

func _on_Net_R_goal() -> void:
	emit_signal("goal", "right")
	last_goal = "right"
	spawn_ball()

func spawn_ball() -> void:
	stop_lines()
	current_ball = ball.instance()
	current_ball.connect("ball_changed_direction", self, "start_lines")
	current_ball.position = Center
	var rand = 25 * (randi()%4 + 1)
	current_ball.velocity = Vector2(
		-255 if randi() % 2 else 255,
		-rand if randi() % 2 else rand
	)
	call_deferred("add_child", current_ball)
	if $Paddle_L is AIPaddle:
		update_ai($Paddle_L, last_goal == "left")
	if $Paddle_R is AIPaddle:
		update_ai($Paddle_R, last_goal == "right")

func update_ai(paddle, increase_difficulty: bool):
	paddle.set_target(current_ball)
	if increase_difficulty:
		paddle.difficulty += 1
		
func start_lines(speed):
	if speed > 1000:
		$SpeedLines/Lines_Left.visible = true
		$SpeedLines/Lines_Right.visible = false
	if speed < -1000:
		$SpeedLines/Lines_Left.visible = false
		$SpeedLines/Lines_Right.visible = true

func stop_lines():
		$SpeedLines/Lines_Left.visible = false
		$SpeedLines/Lines_Right.visible = false
