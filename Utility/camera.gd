extends Camera2D

# Smoothly move camera between player and cameraTarget
func update_camera():
	# print(get_clamped_mouse_position(get_viewport().get_mouse_position()))
	var cameraTarget = lerp(Vector2(), get_clamped_mouse_position(get_viewport().get_mouse_position()) - Vector2(get_viewport_rect().size / 2), 0.20)
	position = lerp(position, cameraTarget, 0.30)

# Return the mouse position bound to the borders of the viewport
func get_clamped_mouse_position(mouse_pos:Vector2):
	return Vector2(clamp(mouse_pos.x, 0.0, get_viewport_rect().size.x), clamp(mouse_pos.y, 0.0, get_viewport_rect().size.y))
