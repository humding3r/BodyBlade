extends State
class_name MobState

signal hit_taken(area)

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func apply_gravity(delta):
	object.velocity.y += gravity * delta

func _on_area_2d_area_entered(area : Area2D):
	if area.is_in_group("Sword"):
		hit_taken.emit(area)
		change_state("hurt")
