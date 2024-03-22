extends PlayerState

const DEBUG_LABEL = "FALLING"

var coyote_threshold : float = 0.25
var coyote_timer : float = 0.0

var jump_buffer_threshold : float = 0.1
var jump_buffer : float = 0.0
var jump_buffered : bool = false

func enter():
	object.animated_sprite.play("idle")
	coyote_timer = 0.0
	jump_buffer = 0.0
	jump_buffered = false

func physics_process(delta):
	apply_gravity(delta)
	move(delta)

	coyote_timer += delta

	if jump_buffered:
		jump_buffer += delta

	if jump_buffer > jump_buffer_threshold:
		jump_buffered = false

	if object.is_on_floor():

		if jump_buffered:
			# print("buffer jump executed!")
			change_state("jump")
			return

		if Input.get_axis("move_left", "move_right") == 0:
			change_state("idle")
		else:
			change_state("run")

	elif Input.is_action_just_pressed("jump"):
		if coyote_timer < coyote_threshold and state_machine.previous_state_name == "run":
			# print("coyote jump executed!")
			change_state("jump")
		elif not object.has_double_jumped:
			# print("double jump executed!")
			change_state("doublejump")
		else:
			jump_buffered = true
	
	else:
		if direction:
			object.animated_sprite.play("run")
		else:
			object.animated_sprite.play("idle")
