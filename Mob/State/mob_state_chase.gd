extends MobState

func physics_process(delta):
	apply_gravity(delta)
	if player.position.x > object.position.x:
		object.velocity.x = 100
	elif player.position.x < object.position.x:
		object.velocity.x = -100

func _on_detection_area_area_exited(area):
	if area.is_in_group("Player"):
		change_state("idle")
