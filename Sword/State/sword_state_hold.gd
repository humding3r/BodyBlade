extends SwordState

@export var charge_threshold : float = 0.5
var charge_time : float = 0.0
var just_caught : bool = false

func enter():
	object.thrown_sprite.hide()
	object.stuck_sprite.hide()
	object.damage_hitbox.set_deferred("disabled", true)
	charge_time = 0.0
	just_caught = true if state_machine.previous_state_name else false
	object.freeze = true

func process(delta):
	object.global_position = object.get_parent().global_position
	
	if Input.is_action_pressed("attack"):
		charge_time += delta
	
	if Input.is_action_just_released("attack"):
		if just_caught:
			just_caught = false
		elif charge_time > charge_threshold:
			change_state("throw")
		else:
			charge_time = 0.0
			object.look_at(object.get_global_mouse_position())
			object.held_animation_player.play("slash")
