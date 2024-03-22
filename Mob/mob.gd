extends CharacterBody2D

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine : Node = $StateMachine
@onready var collision_body : CollisionShape2D = $CollisionBody
@onready var display_text : Label = $Label
@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready():
	state_machine.change_state("fall")

func _physics_process(delta):
	state_machine.physics_process(delta)
	move_and_slide()

