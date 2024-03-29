extends CharacterBody2D

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine : Node = $StateMachine
@onready var collision_body : CollisionShape2D = $CollisionBody
@onready var debug_label : Label = $Label
@onready var animation_player : AnimationPlayer = $AnimationPlayer

func _ready():
	state_machine.change_state("fall")

func _physics_process(delta):
	state_machine.physics_process(delta)
	move_and_slide()

func _on_base_hit_taken(area):
	if not area: return
	debug_label.text = str("Owie! I took ",  area.owner.damage_value, " damage!")
	debug_label.show()
	await get_tree().create_timer(1).timeout
	debug_label.hide()
