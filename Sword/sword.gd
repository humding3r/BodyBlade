extends Node2D

@export var damage_value = 1

@onready var animated_sprite : AnimatedSprite2D= $AnimatedSprite2D
@onready var hitbox : CollisionShape2D = $DamageZone/DamageHitbox
@onready var Player : CharacterBody2D = $".."

# Hide the sword on ready.
func _ready():
	animated_sprite.hide()
	hitbox.set_deferred("disabled", true)

@warning_ignore("unused_parameter")
func _process(delta):
	# print(Input.is_action_just_pressed("attack"))
	if Input.is_action_just_released("attack") and Player.sword_held and not Player.just_picked_up and Player.charge_time < Player.charge_threshold:
		look_at(get_global_mouse_position())
		animated_sprite.show()
		animated_sprite.play("default")

# End animation when complete
func _on_animated_sprite_2d_animation_finished():
	# print("Animation finished!")
	animated_sprite.hide()
	animated_sprite.stop()
	hitbox.set_deferred("disabled", true)
	animated_sprite.flip_v = not animated_sprite.flip_v
	

func _on_animated_sprite_2d_frame_changed():
	if animated_sprite.get_frame() == 1:
		# print("Hitbox active!")
		hitbox.set_deferred("disabled", false)
	else:
		hitbox.set_deferred("disabled", true)
