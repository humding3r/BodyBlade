extends Node2D

@export var damage_value = 2
@export var knockback_factor : int = 2

@onready var collision_hitbox : CollisionShape2D = $CollisionHitbox
@onready var pickup_area : Area2D = $PickupArea
@onready var damage_hitbox : CollisionShape2D = $DamageArea/DamageHitbox
@onready var held_animation_player : AnimationPlayer = $AnimationPlayer
@onready var sword_animation : AnimationPlayer = $Spin
@onready var thrown_sprite : Sprite2D = $ThrownSprite
@onready var stuck_sprite : AnimatedSprite2D = $StuckSprite
@onready var state_machine : Node = $StateMachine

var times_bounced : int
const SPRITE_OFFSET_X = 4
const SPRITE_OFFSET_Y = 4
const BOUNCE_SCALE := Vector2(0.75, 0.65) 

func _ready():
	state_machine.change_state("hold")

func _physics_process(delta):
	state_machine.physics_process(delta)

func _process(delta):
	state_machine.process(delta)
