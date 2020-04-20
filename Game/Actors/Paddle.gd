extends KinematicBody2D
class_name Paddle

var direction = Vector2(0, 0)
var velocity = Vector2.ZERO
var Acceleration = 0.2
const Friction = 0.333
export var max_speed = 500

var fixed_x = get_global_position().x
var grip_position = fixed_x + 4

var connected_ball
var stored_velocity = 0

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	velocity = calculate_velocity(get_direction())
	var _err = move_and_collide(velocity * delta)

func calculate_velocity(_direction: Vector2):
	return Vector2(
		_calculate_lerp(_direction.x, velocity.x),
		_calculate_lerp(_direction.y, velocity.y)
		)
	
func _calculate_lerp(_direction, _velocity):
	if _direction == 0.0:
		return lerp(_velocity, 0, Friction)
	return lerp(_velocity, _direction * max_speed, Acceleration)

func get_direction(): 
	# OVERRIDE THIS FUNCTION
	return direction 

func _on_PaddleCenter_body_entered(body: Node) -> void:
	if (connected_ball != body):
		var _err = body.connect("end_stop", self, "_on_ball_move")
		connected_ball = body
	
	body.hit_stop()
	body.set_global_position(Vector2(grip_position - 10,body.get_global_position().y))
	$Sprite.set_frame(1)
	if abs(body.velocity.x / 2000) > 0.3:
		$AudioStreamPlayer.play()

func _on_ball_move():
	$Sprite.set_frame(0)
	set_global_position(Vector2(fixed_x, get_global_position().y))
	$AudioStreamPlayer.stop()

func set_grip_position_offset(offset = 4):
	grip_position = fixed_x + offset
