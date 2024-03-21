extends State
class_name PlayerState

const SPEED : float = 300
const DOUBLETAP_DELAY = 0.20
const JUMP_VELOCITY : float = -350.0
const DOUBLE_JUMP_VELOCITY : float = -350.0
const MAX_DASH_SPEED : float = 750.0

@onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : float = 0.0
var is_accessible : bool = true

func _ready():
	Global.double_tap.connect(_on_double_tap)

func move(delta):
	direction = Input.get_axis("move_left", "move_right")

	if direction:
		object.velocity.x = int(lerp(object.velocity.x, direction * (SPEED + object.current_dash_speed), 10 * delta))
	else:
		object.velocity.x = int(lerp(object.velocity.x, 0.0, 10 * delta))

	object.current_dash_speed = object.current_dash_speed - delta * 1500 if object.current_dash_speed > 0.0 else 0.0

func apply_gravity(delta):
	object.velocity.y += gravity * delta

func _on_double_tap(action : String):
	# print("Received double tap of ", action)
	if action == "move_right" or action == "move_left":
		change_state("dash")