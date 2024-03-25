extends SwordState

var charge_time : float = 0.0
@export var charge_threshold : float = 0.5

func enter():
	object.thrown_sprite.hide()
	object.stuck_sprite.hide()
	object.pickup_hitbox.set_deferred("disabled", true)
	object.damage_hitbox.set_deferred("disabled", true)
	object.freeze = true

func process(delta):
	object.global_position = object.get_parent().global_position
	
	if Input.is_action_pressed("attack"):
		charge_time += delta
	
	if Input.is_action_just_released("attack"):
		if charge_time > charge_threshold:
			change_state("throw")
		else:
			charge_time = 0.0
