extends CharacterBody2D

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player_variables = get_node("/root/PlayerVariables")
@onready var global = get_node("/root/Global")
@onready var display_text : Label = $Label

func _on_ready():
	display_text.hide()
	pass # Replace with function body.

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	move_and_slide()

func _on_area_2d_area_entered(area : Area2D):
	if area.is_in_group("Sword"):
		var attacker_damage = area.owner.damage_value
		take_damage(attacker_damage)

func take_damage(damage : int):
	display_text.text = str("Owie! I took ",  damage, " damage!")
	display_text.show()
	await get_tree().create_timer(1).timeout
	display_text.hide()

