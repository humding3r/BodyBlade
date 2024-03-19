extends Line2D

@onready var base_state : Node = self.owner.get_node("StateMachine/Base")
@export var max_length : int = 250

var queue : Array
var is_dashing : bool = false

func _ready():
	base_state.connect("exit_dash", _on_exit_dash)

func _process(_delta):
	if is_dashing:
		queue.push_front(get_parent().position)
		
		if queue.size() > max_length:
			queue.pop_back()
		
		clear_points()
		
		for point in queue:
			add_point(point)
	else:
		if !queue.is_empty():
			queue.push_front(get_parent().position)
		clear_points()
		queue.pop_back()
		queue.pop_back()
		for point in queue:
			add_point(point)

func _on_enter_dash():
	print("Player is dashing!")
	is_dashing = true

func _on_exit_dash():
	print("Player is no longer dashing!")
	is_dashing = false
