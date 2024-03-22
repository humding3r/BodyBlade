extends MobState

func physics_process(delta):
	apply_gravity(delta)
	if object.is_on_floor():
		change_state("idle")
