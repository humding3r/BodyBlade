extends MobState

func enter():
	for area in object.detection_area.get_overlapping_areas():
		if area.is_in_group("Player"):
			change_state("chase")

func physics_process(delta):
	apply_gravity(delta)
	if not object.is_on_floor():
		if object.velocity.y > 0:
			change_state("fall")
	object.velocity.x = int(lerp(object.velocity.x, 0.0, 10 * delta))

func _on_detection_area_area_entered(area):
	if area.is_in_group("Player"):
		change_state("chase")
