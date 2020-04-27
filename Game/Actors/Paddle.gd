extends KinematicBody2D
class_name Paddle

var direction = Vector2(0, 0)
var velocity = Vector2.ZERO
var acceleration = 0.2
const FRICTION = 0.333
var max_speed = 500

var current_ball

var collision
var fixed_x

func _ready() -> void:
	pass
	
func _init():
	fixed_x = position.x

func _physics_process(delta: float) -> void:
	velocity = calculate_velocity(get_direction())
	collision = move_and_collide(velocity * delta)
	position.x = fixed_x
	

func calculate_velocity(_direction: Vector2):
	return Vector2(
		_calculate_lerp(_direction.x, velocity.x),
		_calculate_lerp(_direction.y, velocity.y)
		)
	
func _calculate_lerp(_direction, _velocity):
	if _direction == 0.0:
		return lerp(_velocity, 0, FRICTION)
	return lerp(_velocity, _direction * max_speed, acceleration)

func get_direction(): 
	# OVERRIDE THIS FUNCTION
	return direction 

func _on_PaddleCenter_body_entered(body: Node):
	if current_ball != body:
		var _err = body.connect("end_stop", self, "_on_PaddleCenter_body_exited", [body])
		current_ball = body
	$Sprite.set_frame(1)
	if abs(body.velocity.x / 2000) > 0.3:
		$AudioStreamPlayer.play()

func _on_PaddleCenter_body_exited(_body: Node) -> void:
	$Sprite.set_frame(0)
	$AudioStreamPlayer.stop()

func _on_hit():
	pass
