extends SwordState

var impact_direction : int

func enter():
	match impact_direction:
		0:
			object.rotation_degrees = 0
		1:
			object.rotation_degrees = -90
		2:
			object.rotation_degrees = -180
		3:
			object.rotation_degrees = -270
	if object.linear_velocity.x >= 0:
		object.stuck_sprite.play("thrown_right")
	else:
		object.stuck_sprite.play("thrown_left")
	object.stuck_sprite.show()
	object.thrown_sprite.hide()
	object.linear_velocity = Vector2.ZERO
	object.freeze = true

func process(delta):
	if Input.is_action_pressed("attack"):
		change_state("return")

func _on_throw_update_impact_direction(new_impact_direction):
	impact_direction = new_impact_direction
