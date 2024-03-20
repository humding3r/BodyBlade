extends Camera2D

@onready var Player : CharacterBody2D = $".."

# Smoothly move camera between player and cameraTarget
func update_camera():
	# print(get_clamped_mouse_position(get_viewport().get_mouse_position()))
	var cameraTarget = lerp(Vector2(), Player.get_clamped_mouse_position(get_viewport().get_mouse_position()) - Vector2(get_viewport_rect().size / 2), 0.20)
	position = lerp(position, cameraTarget, 0.30)