extends PlayerState

const DEBUG_LABEL = "DASHING"

@onready var dash_cooldown = $DashCooldown
var is_accessible : bool = true

func enter():
	object.animated_sprite.play("run")
	object.current_dash_speed = MAX_DASH_SPEED
	dash_cooldown.start()
	is_accessible = false

func physics_process(delta):
	apply_gravity(delta)
	move(delta)

	if object.current_dash_speed > 0 and object.current_dash_speed - delta * 1500 <= 0.0:
		if object.is_on_floor():
			if direction:
				change_state("run")
			else:
				change_state("idle")
		else:
			change_state("fall")

	if Input.is_action_just_pressed("jump"):
		change_state("jump")


func _on_dash_cooldown_timeout():
	is_accessible = true
