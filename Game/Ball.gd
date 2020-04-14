extends KinematicBody2D


var velocity = Vector2(1, 0)
var max_speed = 800.0
var in_net = false

signal end_stop

func _ready() -> void:
	hit_stop()
	
func _physics_process(delta: float) -> void:
	if in_net:
		queue_free()

	var collision = move_and_collide(velocity * delta)
	if collision != null:
		var bounce_direction = collision.get_normal()
		var collider_velocity = collision.get_collider_velocity()
		velocity.x += -5 if velocity.x < 0 else 1
		velocity = velocity.bounce(bounce_direction)
		velocity += collider_velocity

func hit_stop():
	$Timer.wait_time = (velocity.x / 3000)
	print($Timer.wait_time)
	$Timer.start()
	set_physics_process(false)
	var direction = 1 if velocity.x > 0 else -1
	velocity.x = lerp(velocity.x, direction * max_speed, 0.1)

func _on_Timer_timeout() -> void:
	set_physics_process(true)
	emit_signal("end_stop")

