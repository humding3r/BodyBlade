extends Line2D

@onready var base_state : Node = self.owner.get_node("StateMachine/Base")
@export var max_length : int = 250

var queue : Array

func _process(_delta):
	if owner.current_dash_speed != 0:
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
