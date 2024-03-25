extends SwordState

var impact_direction : int

func enter():
	match impact_direction:
		0:
			object.stuck_sprite.rotation_degrees = 0
			object.stuck_sprite.position = Vector2(0, SPRITE_OFFSET_Y)
		1:
			object.stuck_sprite.rotation_degrees = -90
			object.stuck_sprite.position = Vector2(SPRITE_OFFSET_X, 0)
		2:
			object.stuck_sprite.rotation_degrees = -180
			object.stuck_sprite.position = Vector2(0, -SPRITE_OFFSET_Y)
		3:
			object.stuck_sprite.rotation_degrees = -270
			object.stuck_sprite.position = Vector2(-SPRITE_OFFSET_X, 0)
	if object.linear_velocity.x >= 0:
		object.stuck_sprite.play("thrown_right")
	else:
		object.stuck_sprite.play("thrown_left")
	object.stuck_sprite.show()
	object.thrown_sprite.hide()
	object.linear_velocity = Vector2.ZERO
	object.freeze = true
