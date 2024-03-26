extends State
class_name SwordState

var times_bounced : int = 0
const BOUNCE_SCALE := Vector2(0.75, 0.65)


func swap():
	var temp = object.get_parent().global_position
	var temp_velocity = object.get_parent().velocity

	if object.get_parent().is_on_floor():
		object.stuck_sprite.rotation_degrees = 0
	else:
		object.stuck_sprite.hide()
		object.thrown_sprite.show()

	object.pickup_area.set_deferred("disabled", true)
	object.get_parent().global_position = object.global_position
	object.get_parent().velocity = object.linear_velocity
	object.global_position = temp
	object.linear_velocity = temp_velocity
	object.pickup_area.set_deferred("disabled", false)
