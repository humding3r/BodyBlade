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
		if object.velocity.x == 0 or not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
			change_state("idle")
		else:
			change_state("run")