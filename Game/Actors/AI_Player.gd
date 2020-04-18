extends Paddle

var target = self

func set_target(_target):
	target = _target

func get_direction():
	var direction_of_target = self.get_global_position()
	if target.is_inside_tree():
		direction_of_target = target.get_global_position() - self.get_global_position()
	if abs(direction_of_target.y) < 10.0:
		direction.y = 0
	else:
		direction.y = 1 if direction_of_target.y > 0 else -1
	return direction

func get_grip_position():
	return self.get_global_position().x + 17
