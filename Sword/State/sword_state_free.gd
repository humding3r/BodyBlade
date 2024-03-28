extends SwordState

func enter():
	object.stuck_sprite.hide()
	object.thrown_sprite.show()
	object.freeze = false

func process(delta):
	if Input.is_action_just_pressed("swap"):
		swap()
		
	if Input.is_action_pressed("attack"):
		change_state("return")

func physics_process(delta):
	check_bounce()
