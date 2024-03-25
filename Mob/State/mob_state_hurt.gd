extends MobState

var attacker_area : Area2D = null
var attacker : Node = null
var attacker_damage : int = 0
var attacker_knockback : int = 1

var knockback_vector : Vector2 = Vector2.ZERO
var base_up_knockback : float = 250.0

func _on_base_hit_taken(area):
	attacker_area = area
	attacker = area.owner
	attacker_damage = attacker.damage_value
	attacker_knockback = attacker.knockback_factor

func enter():
	object.velocity += calculate_knockback()
	object.animation_player.play("hurt")

func physics_process(delta):
	apply_gravity(delta)
	if object.velocity.y > 0:
		change_state("fall")

func calculate_knockback() -> Vector2:
	#if attacker_area.global_position.x > object.global_position.x:
		#return Vector2(-250, -base_up_knockback)
	#if attacker_area.global_position.x < object.global_position.x:
		#return Vector2(250, -base_up_knockback)
	print(Vector2.RIGHT.rotated(attacker.global_rotation))
	if attacker_area.is_in_group("Projectile"):
		return Vector2(0.0, -base_up_knockback) + (attacker.linear_velocity / 10) \
			* attacker_knockback + Vector2(RandomNumberGenerator.new().randf_range(-10.0, 10.0), RandomNumberGenerator.new().randf_range(-10.0, 10.0))
	return Vector2(0.0, -base_up_knockback) + Vector2.RIGHT.rotated(attacker.global_rotation) \
			* 100 * attacker_knockback + Vector2(RandomNumberGenerator.new().randf_range(-10.0, 10.0), RandomNumberGenerator.new().randf_range(-10.0, 10.0))

