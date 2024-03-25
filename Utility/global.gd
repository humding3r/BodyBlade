extends Node
signal double_tap

const DOUBLETAP_DELAY : float = 0.2

var doubletap_time : float = DOUBLETAP_DELAY
var last_keycode : int = 0

func _ready() -> void:
	#Engine.max_fps = 60
	pass

func _process(delta : float) -> void:
	if doubletap_time > 0.0:
		doubletap_time = clamp(doubletap_time - delta, 0.0, DOUBLETAP_DELAY)

func _input(event : InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo(): # If a key is pressed (and not held)
		if last_keycode == event.keycode and doubletap_time > 0: # If the key is the same as the last key and doubletap_time hasn't timed out
			for action_name : StringName in InputMap.get_actions():
				if event.is_action(action_name):
					# print("Action double-tapped: ", action_name)
					double_tap.emit(action_name)
			last_keycode = 0
		else:
			last_keycode = event.keycode
		doubletap_time = DOUBLETAP_DELAY
