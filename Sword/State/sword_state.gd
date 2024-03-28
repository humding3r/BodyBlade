extends State
class_name SwordState

signal update_impact_direction(new_impact_direction : int)

var impact_direction : int
var times_bounced : int = 0
const BOUNCE_SCALE := Vector2(0.75, 0.65)

func swap():
	var temp = object.get_parent().global_position
	var temp_velocity = object.get_parent().velocity

	if object.get_parent().is_on_floor():
		object.rotation_degrees = 0
	else:
		change_state("free")

	object.pickup_area.set_deferred("disabled", true)
	object.get_parent().global_position = object.global_position
	object.get_parent().velocity = object.linear_velocity
	object.global_position = temp
	object.linear_velocity = temp_velocity
	object.pickup_area.set_deferred("disabled", false)

func check_bounce():
	var collision_info = object.move_and_collide(Vector2.ZERO)
	if collision_info:
		times_bounced += 1
		
		if (collision_info.get_angle() > 0) and (collision_info.get_angle() < PI / 4):
			impact_direction = 0
		if (collision_info.get_angle() >= PI / 4) and (collision_info.get_angle() < (3 * PI) / 4):
			impact_direction = 1 if object.linear_velocity.x >= 0 else 3
		if (collision_info.get_angle() >= (3 * PI) / 4):
			impact_direction = 2
			
		if check_stick(impact_direction, times_bounced):
			times_bounced = 0
			update_impact_direction.emit(impact_direction)
			change_state("stuck")
		else:
			object.linear_velocity = object.linear_velocity.bounce(collision_info.get_normal())
			object.linear_velocity *= BOUNCE_SCALE

func check_stick(impact_direction : int, count : int):
	
	if Input.is_action_pressed("attack"): return false
	if count == 3: return true
	
	if abs(object.linear_velocity.x) > 600:
		if impact_direction == 1 or impact_direction == 3:
			return true
	if abs(object.linear_velocity.y) > 600:
		if impact_direction == 0 or impact_direction == 2:
			return true
			
	return false
