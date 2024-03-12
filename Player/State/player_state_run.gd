extends PlayerState 

const DEBUG_LABEL = "RUNNING"

func _ready():
	Global.double_tap.connect(_on_double_tap)

func enter():
	object.animated_sprite.play("run")

func physics_process(delta):
	apply_gravity(delta)
	move(delta)

	if object.velocity.y > 0 and not object.is_on_floor():
		change_state("fall")
	elif Input.is_action_just_pressed("jump"):
		change_state("jump")
	elif object.velocity.x == 0 or not Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		change_state("idle")

func _on_double_tap(action : String):
	# print("Received double tap of ", action)
	if action == "move_right" or action == "move_left":
		change_state("dash")
