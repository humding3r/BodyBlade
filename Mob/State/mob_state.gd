extends State
class_name MobState

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func apply_gravity(delta):
	object.velocity.y += gravity * delta
