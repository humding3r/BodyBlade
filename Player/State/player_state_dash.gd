extends PlayerState
signal enter_dash
signal exit_dash

const DEBUG_LABEL = "DASHING"

func enter():
	enter_dash.emit()
	object.animated_sprite.play("run")
	current_dash_speed = MAX_DASH_SPEED

func exit():
	exit_dash.emit()

func physics_process(delta):
	apply_gravity(delta)
	move(delta)
	if current_dash_speed > 0 and current_dash_speed - delta * 1500 <= 0.0:
		if object.is_on_floor():
			if Input.get_axis("move_left", "move_right") == 0:
				change_state("idle")
			else:
				change_state("run")
		else:
			change_state("fall")
	if Input.is_action_just_pressed("jump"):
		change_state("jump")
