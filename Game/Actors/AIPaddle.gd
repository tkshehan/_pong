extends Paddle
class_name AIPaddle

var target = self
var difficulty = 1
var handicap = 10

var default_max_speed = 400
var default_acceleration = 0.15

var timer
var default_wait_time = 0.33
var paused = false

func _init():
	timer = Timer.new()
	timer.wait_time = default_wait_time
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)

func set_target(_target):
	target = _target
	reset_difficulty()

func reset_difficulty():
	handicap = 11 - difficulty
	max_speed = default_max_speed
	acceleration = default_acceleration

func get_direction():
	if paused:
		return Vector2.ZERO
	var direction_of_target = self.get_global_position() # Default until a target is made
	if target.is_inside_tree():
		direction_of_target = target.get_global_position() - self.get_global_position()
	if abs(direction_of_target.y) < 10.0:
		direction.y = 0
	else:
		direction.y = 1 if direction_of_target.y > 0 else -1
	return direction

func on_bounce():
	max_speed -= handicap * 2.5
	acceleration = max(acceleration - handicap * 0.01, 0.05)
	paused = true
	timer.start()


func _on_timer_timeout():
	paused = false
