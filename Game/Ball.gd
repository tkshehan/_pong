extends KinematicBody2D
class_name Ball

var velocity = Vector2(1, 0)
var in_net = false
var waiting_destruction = false

var collider = null
var is_stopped = false

const MAX_VELOCITY = Vector2(3000.0, 200.0)
var min_velocity = Vector2(0,0)
const ACCELERATION = 50

const MIN_HITSTOP = 0.05

signal ball_changed_direction(speed)
signal end_stop

func _ready() -> void:
	hit_stop()
	
func _physics_process(delta: float) -> void:
	if waiting_destruction:
		return
	
	if in_net:
		$CollisionShape2D.queue_free()
		$Sprite.queue_free()
		$Trail.queue_free()
		emit_signal("end_stop")
		waiting_destruction = true
		if abs(velocity.x) / 2000 > 0.2:
			$GoalSounds.play()
			var _err = $GoalSounds.connect("finished", self, "queue_free")
		else:
			var _err = $BounceSounds.connect("finished", self, "queue_free")
		return
	
	if is_stopped and $Timer.is_stopped():
		if collider.get_direction().y != 0:
			velocity.y += (50.0 * collider.get_direction().y)
		is_stopped = false
		
	var collision = move_and_collide(velocity * delta, false)
	if collision != null:
		collider = collision.collider
		play_sfx()
		var bounce_direction = collision.get_normal()
		velocity = velocity.bounce(bounce_direction)
		
		if collider is AIPaddle:
			collider.on_hit()
		
		if collider.get_parent() is Paddle:
			collider = collider.get_parent()
			is_stopped = true
			hit_stop()
			if collider is AIPaddle:
				collider.on_hit()
		emit_signal("ball_changed_direction", velocity.x)
	
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
	$BounceSounds.play_sound()
