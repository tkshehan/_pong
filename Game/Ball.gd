extends KinematicBody2D

var velocity = Vector2(1, 0)
var in_net = false
var waiting_destruction = false

const MAX_VELOCITY = Vector2(3000.0, 200.0)
var min_velocity = Vector2(0,0)
const MAX_ANGLE = 45.0
const ACCELERATION = 50

const MIN_HITSTOP = 0.05

signal end_stop

func _ready() -> void:
	hit_stop()
	
func _physics_process(delta: float) -> void:
	if waiting_destruction:
		return
	
	if in_net:
		$CollisionShape2D.queue_free()
		$Sprite.queue_free()
		emit_signal("end_stop")
		var _err = $BallSounds.connect("finished", self, "queue_free")
		waiting_destruction = true
		return

	var collision = move_and_collide(velocity * delta)
	if collision != null:
		if collision.collider is AIPaddle:
			collision.collider.on_bounce()
		play_sfx()
		var bounce_direction = collision.get_normal()
		var collider_velocity = collision.get_collider_velocity()
		velocity = velocity.bounce(bounce_direction)
		velocity += collider_velocity
	
	var y_dir = 1 if velocity.y > 0 else -1	
	var x_dir = 1 if velocity.x > 0 else -1
	if abs(velocity.x) > min_velocity.x:
		min_velocity.x = abs(velocity.x)
	
	velocity.y = min(abs(velocity.y), MAX_VELOCITY.y) * y_dir
	velocity.x = max(abs(velocity.x), min_velocity.x) * x_dir

func hit_stop():
	$Timer.wait_time = stepify(max(MIN_HITSTOP, abs((velocity.x) / 3000)), 0.1)
	$Timer.start()
	set_physics_process(false)
	var x_dir = 1 if velocity.x > 0 else -1
	velocity.x = (abs(velocity.x) + ACCELERATION) * x_dir

func _on_Timer_timeout() -> void:
	set_physics_process(true)
	emit_signal("end_stop")

func play_sfx():
	$BallSounds.play_sound()
