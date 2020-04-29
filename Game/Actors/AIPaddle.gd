extends Paddle
class_name AIPaddle

var target = self

var difficulty = 1
var stamina = 100
var shield = 3

var shield_texture = load("res://assets/paddle/paddle-shield.png")
var strong_texture = load("res://assets/paddle/paddle-active.png")
var normal_texture = load("res://assets/paddle/paddle.png")
var break_texture = load("res://assets/paddle/paddle-break.png")

var sfx_player
var break_sound = load("res://assets/sfx/mirror-break.wav")
var crack_sound = load("res://assets/sfx/glass-break.wav")

var default_max_speed = 400
var default_acceleration = 0.15

var timer
var default_wait_time = 0.33
var paused = false

func _init():
	sfx_player = AudioStreamPlayer2D.new()
	sfx_player.volume_db = -25
	add_child(sfx_player)
	timer = Timer.new()
	timer.wait_time = default_wait_time
	timer.connect("timeout", self, "_on_timer_timeout")
	add_child(timer)

func set_target(_target):
	target = _target
	reset_handicap()

func reset_handicap():
	max_speed = default_max_speed
	acceleration = default_acceleration
	stamina = stamina_ammount(difficulty)
	shield = shield_amount(difficulty)
	if shield > 0:
		$Sprite.set_texture(shield_texture)
	else:
		$Sprite.set_texture(normal_texture)
		
func stamina_ammount(difficult):
	if difficulty <= 2: return 10 * difficulty + 60
	if difficulty <= 5: return 10 * difficulty + 50
	if difficulty <= 8: return 10 * difficulty + 50
	if difficulty == 9: return 10 * difficulty + 50
	if difficulty == 10: return 10 * difficulty + 50
	return 0

func shield_amount(difficulty):
	if difficulty <= 2: return 0
	if difficulty <= 5: return 2
	if difficulty <= 8: return 3
	if difficulty == 9: return 4
	if difficulty == 10: return 5
	return 0

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

func on_hit():
	if shield > 0:
		shield -= 1
		if shield == 0:
			sfx_player.set_stream(crack_sound)
			sfx_player.play()
			if stamina > 100:
				$Sprite.set_texture(strong_texture)
			else:
				$Sprite.set_texture(normal_texture)
	else:
		max_speed = default_max_speed * stamina * 0.01
		acceleration = default_acceleration * stamina * 0.01
		stamina -= 10
		if stamina > 95 and stamina <= 100:
			$Sprite.set_texture(normal_texture)
		if stamina <= 30 and stamina > 25:
			sfx_player.set_stream(break_sound)
			sfx_player.play()
			$Sprite.set_texture(break_texture)
	paused = true
	timer.start()


func _on_timer_timeout():
	paused = false
