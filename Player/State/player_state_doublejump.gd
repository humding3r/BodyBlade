extends PlayerState

const DEBUG_LABEL = "DOUBLE JUMPING"

func enter():
	object.velocity.y = DOUBLE_JUMP_VELOCITY
	object.has_double_jumped = true

func physics_process(delta):
	apply_gravity(delta)
	move(delta)
	if not object.is_on_floor():
		if object.velocity.y > 0:
			change_state("fall")
	else:
		if direction:
			change_state("run")
		else:
			change_state("idle")