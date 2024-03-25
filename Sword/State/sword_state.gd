extends State
class_name SwordState

var times_bounced : int = 0
const BOUNCE_SCALE := Vector2(0.75, 0.65) 
const SPRITE_OFFSET_X = 4
const SPRITE_OFFSET_Y = 4

func check_bounce():
	var collision_info = object.move_and_collide(Vector2.ZERO)
	if collision_info:
		var impact_angle : int
		if (collision_info.get_angle() > 0) and (collision_info.get_angle() < PI / 4):
			impact_angle = 0
		if (collision_info.get_angle() >= PI / 4) and (collision_info.get_angle() < (3 * PI) / 4):
			if object.linear_velocity.x >= 0:
				impact_angle = 1
			else:
				impact_angle = 3
		if (collision_info.get_angle() >= (3 * PI) / 4):
			impact_angle = 2
		if check_stick(impact_angle, times_bounced):
			times_bounced = 0
			change_state("stuck")
			#stick(collision_info, impact_angle)
		else:
			object.linear_velocity = object.linear_velocity.bounce(collision_info.get_normal())
			object.linear_velocity *= BOUNCE_SCALE
			times_bounced += 1

func check_stick(impact_angle : int, count : int):
	if Input.is_action_pressed("attack"): return false
	if count == 3:
		return true
	if abs(object.linear_velocity.x) > 600:
		if impact_angle == 1 or impact_angle == 3:
			return true
	if abs(object.linear_velocity.y) > 600:
		if impact_angle == 0 or impact_angle == 2:
			return true
	return false

func swap():
	var temp = object.get_parent().global_position
	var temp_velocity = object.get_parent().velocity

	if object.get_parent().is_on_floor():
		object.stuck_sprite.rotation_degrees = 0
		object.stuck_sprite.position = Vector2(0, SPRITE_OFFSET_Y)
	else:
		object.stuck_sprite.hide()
		object.thrown_sprite.show()

	object.get_parent().pickup_zone.set_deferred("disabled", true)
	object.get_parent().global_position = object.global_position
	object.get_parent().velocity = object.linear_velocity
	object.global_position = temp
	object.linear_velocity = temp_velocity
	object.pickup_zone.set_deferred("disabled", false)
