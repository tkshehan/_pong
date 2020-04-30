extends Line2D

func _process(_delta):
	global_position = Vector2.ZERO
	global_rotation = 0
	var point = get_parent().get_position()
	add_point(point)
	
	if get_point_count() > 100:
		remove_point(0)

