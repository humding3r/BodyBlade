extends Node
class_name StateMachine

signal transitioned(state_name)

var states = {}
var current_state
var current_state_name
var previous_state_name

@export var debug := false

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.object = get_parent()
			child.state_machine = self

func change_state(target_state_name):
	if target_state_name == current_state_name: return
	if "is_accessible" in states[target_state_name] and not states[target_state_name].is_accessible: return

	if current_state:
		current_state.exit()
		previous_state_name = current_state_name

	current_state_name = target_state_name.to_lower()
	current_state = states[current_state_name]
	current_state.enter()

	emit_signal("transitioned", current_state_name)

	if debug:
		print(previous_state_name, " -> ", current_state_name)

func physics_process(delta):
	if not current_state: return
	current_state.physics_process(delta)

func process(delta):
	if not current_state: return
	current_state.process(delta)
