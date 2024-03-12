extends State
class_name PlayerState

const SPEED : float = 300.0
const DOUBLETAP_DELAY = 0.25
const JUMP_VELOCITY : float = -350.0
const DOUBLE_JUMP_VELOCITY : float = -350.0
const MAX_DASH_SPEED : float = 500.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var current_dash_speed : float = 0.0

func move(delta):
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		object.velocity.x = lerp(object.velocity.x, direction * (SPEED + current_dash_speed), 10 * delta)
	else:
		object.velocity.x = lerp(object.velocity.x, 0.0, 15 * delta)
	current_dash_speed = current_dash_speed - delta * 1500 if current_dash_speed > 0.0 else 0.0

func apply_gravity(delta):
	object.velocity.y += gravity * delta
