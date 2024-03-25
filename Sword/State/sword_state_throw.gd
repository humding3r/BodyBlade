extends SwordState

@export var speed = 500
@export var damage_value : int = 2
@export var knockback_factor : int = 2

func enter():
	object.show()
	object.freeze = false
	EventBus.sword_thrown.emit()
	
	var direction = (object.get_global_mouse_position() - object.global_position).normalized()
	var speed_augment = (cos(abs(object.get_angle_to(object.get_global_mouse_position()))) * 100)
	var throw_velocity = direction * (speed + speed_augment) + object.get_parent().velocity
	
	if object.get_global_mouse_position().x < object.global_position.x:
		object.sword_animation.play("spin_cc")
	elif object.get_global_mouse_position().x > object.global_position.x:
		object.sword_animation.play("spin_cw")
	object.collision_hitbox.set_deferred("disabled", false)
	object.apply_central_impulse(throw_velocity)
	object.show()
	object.thrown_sprite.show()
	object.damage_hitbox.set_deferred("disabled", false)

func physics_process(delta):
	check_bounce()
	
	if Input.is_action_pressed("attack"):
		change_state("return")

