extends PlayerState

const DEBUG_LABEL = "IDLING"

func enter():
	object.animated_sprite.play("idle")

func physics_process(delta):
	apply_gravity(delta)
	move(delta)

	if Input.is_action_just_pressed("jump"):
		state_machine.change_state("jump")
		return
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.change_state("run")
	
	if object.velocity.y > 0 and not object.is_on_floor():
		state_machine.change_state("fall")
