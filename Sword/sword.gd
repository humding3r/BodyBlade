extends Node2D

@export var damage_value = 1
@export var knockback_factor : int = 1

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var sprite : Sprite2D = $Sprite2D
@onready var Player : CharacterBody2D = $".."

func _input(_event):
	# print(Input.is_action_just_pressed("attack"))
	if Input.is_action_just_released("attack") and Player.sword_held and not Player.just_picked_up and Player.charge_time < Player.charge_threshold:
		look_at(get_global_mouse_position())
		animation_player.play("slash")

func _on_animation_player_animation_finished(_anim_name):
	sprite.flip_v = not sprite.flip_v
