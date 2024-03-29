extends CharacterBody2D

@export var debug : bool = false

@onready var charge_time = 0.0
@onready var charge_threshold = 0.5

@onready var just_picked_up : bool = false

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var Camera : Camera2D = $Camera2D
@onready var debug_label : Label = $DebugLabel
@onready var state_machine : Node = $StateMachine

var current_dash_speed : float = 0.0
var has_double_jumped : bool = false

func _physics_process(delta):
	state_machine.physics_process(delta)
	move_and_slide()
	Camera.update_camera()
	update_facing_direction()
	if debug: update_debug_label()

func _ready():
	state_machine.change_state("fall")
	

# Make player face cursor
func update_facing_direction():
	if get_global_mouse_position().x > position.x:
		animated_sprite.flip_h = false
	elif get_global_mouse_position().x < position.x:
		animated_sprite.flip_h = true

func update_debug_label():
	if state_machine.current_state:
		debug_label.text = str("ELLIOT THE ", state_machine.current_state.DEBUG_LABEL, " BEAST OF WOODFIELD")
	
