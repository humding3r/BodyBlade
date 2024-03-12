extends Node
signal double_tap

const DOUBLETAP_DELAY = 0.25

var doubletap_time = DOUBLETAP_DELAY
var last_keycode = 0

func _ready():
	for actionName in InputMap.get_actions():
		print("%s:" % actionName)
		for inputEvent in InputMap.action_get_events(actionName):
			print("	%s" % inputEvent.as_text())

func _input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo(): # If a key is pressed (and not held)
		if last_keycode == event.keycode and doubletap_time >= 0: # If the key is the same as the last key and doubletap_time hasn't timed out
			for action_name in InputMap.get_actions():
				if event.is_action(action_name):
					# print("Action double-tapped: ", action_name)
					double_tap.emit(action_name)
			last_keycode = 0
		else:
			last_keycode = event.keycode
		doubletap_time = DOUBLETAP_DELAY