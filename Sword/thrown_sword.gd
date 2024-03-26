extends Node2D

@export var throw_speed = 500
@export var return_speed = 100
@export var damage_value = 2
@export var knockback_factor : int = 2

@onready var collision_hitbox : CollisionShape2D = $CollisionHitbox
@onready var pickup_area : Area2D = $PickupArea
@onready var damage_hitbox : CollisionShape2D = $DamageArea/DamageHitbox
@onready var sword_animation : AnimationPlayer = $Spin
@onready var thrown_sprite : Sprite2D = $ThrownSprite
@onready var stuck_sprite : AnimatedSprite2D = $StuckSprite
@onready var state_machine : Node = $StateMachine

var times_bounced : int
const SPRITE_OFFSET_X = 4
const SPRITE_OFFSET_Y = 4
const BOUNCE_SCALE := Vector2(0.75, 0.65) 

#func _physics_process(delta):
	#sword_body.get_global_transform()
#
	#var target = (get_global_mouse_position() - player.global_position).normalized()
	#var speed_augment = (cos(abs(player.get_angle_to(get_global_mouse_position()))) * 100)
	#var final_throw_velocity = target * (throw_speed + speed_augment)
#
	#if player.sword_held == true:
		#sword_body.position = player.position
	#
	#check_bounce()
#
	#if Input.is_action_pressed("attack") and player.sword_held:
		#player.charge_time += delta
#
	#if Input.is_action_just_released("attack") and player.sword_held:
		#if player.charge_time > player.charge_threshold and not player.just_picked_up:
			#throw(final_throw_velocity)
			#player.charge_time = 0.0
		#else:
			#player.charge_time = 0.0
			#player.just_picked_up = false
	#
	#if Input.is_action_pressed("attack") and not player.sword_held:
		#stuck_sprite.hide()
		#if pickup_zone.overlaps_area($"../Area2D"):
			#pick_up()
		#else:
			#thrown_sprite.show()
			#sword_body.freeze = false
			#damage_value = 3
			#knockback_factor = 4
			#sword_body.apply_central_impulse((player.global_position - sword_body.global_position).normalized() * return_speed)
	#elif not Input.is_action_pressed("attack") and not player.sword_held:
		#damage_value = 2
		#knockback_factor = 2
	#
	#if Input.is_action_just_pressed("swap") and not player.sword_held:
		#swap()
#
#func _ready():
	#sword_body.hide()
	#stuck_sprite.hide()
	#collision_body.set_deferred("disabled", true)
	#hitbox.set_deferred("disabled", true)
	#player.just_picked_up = false
#
#func check_bounce():
	#var collision_info = sword_body.move_and_collide(Vector2.ZERO)
	#if collision_info:
		#var impact_angle : int
		#if (collision_info.get_angle() > 0) and (collision_info.get_angle() < PI / 4):
			#impact_angle = 0
		#if (collision_info.get_angle() >= PI / 4) and (collision_info.get_angle() < (3 * PI) / 4):
			#if sword_body.linear_velocity.x >= 0:
				#impact_angle = 1
			#else:
				#impact_angle = 3
		#if (collision_info.get_angle() >= (3 * PI) / 4):
			#impact_angle = 2
		#if check_stick(impact_angle, times_bounced) and (not player.sword_held) and (not Input.is_action_pressed("attack")):
			#stick(collision_info, impact_angle)
		#else:
			#sword_body.linear_velocity = sword_body.linear_velocity.bounce(collision_info.get_normal())
			#sword_body.linear_velocity *= BOUNCE_SCALE
			#times_bounced += 1
#
#func throw(speed : Vector2):
	## print(speed)
#
	#times_bounced = 0
	#sword_body.freeze = true
	#player.sword_held = false
	#sword_body.freeze = false
	#
	#if get_global_mouse_position().x < player.global_position.x:
		#sword_animation.play("spin_cc")
	#elif get_global_mouse_position().x > player.global_position.x:
		#sword_animation.play("spin_cw")
	#collision_body.set_deferred("disabled", false)
	#sword_body.apply_central_impulse(speed + player.velocity)
	#sword_body.show()
	#thrown_sprite.show()
	#hitbox.set_deferred("disabled", false)
#
#func pick_up():
	#sword_body.hide()
	#player.sword_held = true
	#player.just_picked_up = true
	#sword_body.freeze = true
	#collision_body.set_deferred("disabled", true)
	#hitbox.set_deferred("disabled", true)
#
#func check_stick(impact_angle : int, count : int):
	#if count == 3:
		#return true
	#if abs(sword_body.linear_velocity.x) > 600:
		#if impact_angle == 1 or impact_angle == 3:
			#return true
	#if abs(sword_body.linear_velocity.y) > 600:
		#if impact_angle == 0 or impact_angle == 2:
			#return true
	#return false
#
#func stick(surface : KinematicCollision2D, impact_direction : int):
	##print("stuck!")
	##print(surface.get_angle())
	##print(impact_direction)
	#match impact_direction:
		#0:
			#stuck_sprite.rotation_degrees = 0
			#stuck_sprite.position = Vector2(0, SPRITE_OFFSET_Y)
		#1:
			#stuck_sprite.rotation_degrees = -90
			#stuck_sprite.position = Vector2(SPRITE_OFFSET_X, 0)
		#2:
			#stuck_sprite.rotation_degrees = -180
			#stuck_sprite.position = Vector2(0, -SPRITE_OFFSET_Y)
		#3:
			#stuck_sprite.rotation_degrees = -270
			#stuck_sprite.position = Vector2(-SPRITE_OFFSET_X, 0)
	#if sword_body.linear_velocity.x >= 0:
		#stuck_sprite.play("thrown_right")
	#else:
		#stuck_sprite.play("thrown_left")
	#stuck_sprite.show()
	#thrown_sprite.hide()
	#sword_body.linear_velocity = Vector2.ZERO
	#sword_body.freeze = true
#
#func swap():
	#var temp = player.global_position
	#var temp_velocity = player.velocity
#
	#if player.is_on_floor():
		#stuck_sprite.rotation_degrees = 0
		#stuck_sprite.position = Vector2(0, SPRITE_OFFSET_Y)
	#else:
		#stuck_sprite.hide()
		#thrown_sprite.show()
#
	#pickup_zone.set_deferred("disabled", true)
	#player.global_position = sword_body.global_position
	#player.velocity = sword_body.linear_velocity
	#sword_body.global_position = temp
	#sword_body.linear_velocity = temp_velocity
	#pickup_zone.set_deferred("disabled", false)

func _ready():
	state_machine.change_state("hold")

func _physics_process(delta):
	state_machine.physics_process(delta)

func _process(delta):
	state_machine.process(delta)
