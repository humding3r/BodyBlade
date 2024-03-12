extends PlayerState

const DEBUG_LABEL = "JUMPING"

func enter():
	object.velocity.y = JUMP_VELOCITY
	object.has_double_jumped = false

func physics_process(delta):
	apply_gravity(delta)
	move(delta)
	if not object.is_on_floor():
		if object.velocity.y > 0:
			change_state("fall")
		if Input.is_action_just_pressed("jump") and not object.has_double_jumped:
			change_state("doublejump")