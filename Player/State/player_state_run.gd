extends PlayerState 

const DEBUG_LABEL = "RUNNING"

func enter():
	object.animated_sprite.play("run")

func physics_process(delta):
	apply_gravity(delta)
	move(delta)

	if object.velocity.y > 0 and not object.is_on_floor():
		change_state("fall")
	elif Input.is_action_just_pressed("jump"):
		change_state("jump")
	elif object.velocity.x == 0 or direction == 0:
		change_state("idle")
