extends MobState

func physics_process(delta):
	apply_gravity(delta)
	if not object.is_on_floor():
		if object.velocity.y > 0:
			change_state("fall")
	object.velocity.x = int(lerp(object.velocity.x, 0.0, 10 * delta))
