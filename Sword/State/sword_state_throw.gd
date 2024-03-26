extends SwordState

signal update_impact_direction(new_impact_direction)

@export var speed : float = 500
@export var damage_value : int = 2
@export var knockback_factor : int = 2

func enter():
	object.show()
	object.freeze = false
	
	var direction = (object.get_global_mouse_position() - object.global_position).normalized()
	var speed_augment = (cos(abs(object.get_angle_to(object.get_global_mouse_position()))) * 100)
	var throw_velocity = direction * (speed + speed_augment) + object.get_parent().velocity
	
	if object.get_global_mouse_position().x < object.global_position.x:
		object.sword_animation.play("spin_cc")
	elif object.get_global_mouse_position().x > object.global_position.x:
		object.sword_animation.play("spin_cw")
	object.collision_hitbox.set_deferred("disabled", false)
	object.apply_central_impulse(throw_velocity)
	object.show()
	object.thrown_sprite.show()
	object.damage_hitbox.set_deferred("disabled", false)

func physics_process(delta):
	if Input.is_action_just_pressed("swap"):
		swap()
	
	var collision_info = object.move_and_collide(Vector2.ZERO)
	if collision_info:
		times_bounced += 1
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
			update_impact_direction.emit(impact_angle)
			change_state("stuck")
			#stick(collision_info, impact_angle)
		else:
			object.linear_velocity = object.linear_velocity.bounce(collision_info.get_normal())
			object.linear_velocity *= BOUNCE_SCALE

	
	if Input.is_action_pressed("attack"):
		change_state("return")

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
