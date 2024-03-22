extends CharacterBody2D

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var state_machine : Node = $StateMachine
@onready var collision_body : CollisionShape2D = $CollisionBody
@onready var display_text : Label = $Label

var knockback_vector : Vector2 = Vector2.ZERO
var knockback_force : int = 3

func _ready():
	state_machine.change_state("fall")

func _physics_process(delta):
	state_machine.physics_process(delta)
	move_and_slide()

func _on_area_2d_area_entered(area : Area2D):
	if area.is_in_group("Sword"):
		var attacker_damage = area.owner.damage_value
		take_damage(attacker_damage)

func take_damage(damage : int):
	velocity.x -= 100
	velocity.y -= 100
	display_text.text = str("Owie! I took ",  damage, " damage!")
	display_text.show()
	await get_tree().create_timer(1).timeout
	display_text.hide()
