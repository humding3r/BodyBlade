extends SwordState

@export var return_speed : int = 100
@export var damage_value : int = 3
@export var knockback_factor : int = 2

func enter() -> void:
	object.thrown_sprite.show()
	object.stuck_sprite.hide()
	object.damage_hitbox.set_deferred("disabled", false)
	object.freeze = false

func physics_process(delta) -> void:
	if Input.is_action_pressed("attack"):
		object.apply_central_impulse((object.get_parent().global_position - object.global_position).normalized() * return_speed)
		
		if object.pickup_area.overlaps_area(object.get_parent().get_node("Area2D")):
			change_state("hold")
