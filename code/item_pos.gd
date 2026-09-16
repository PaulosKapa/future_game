extends Marker3D
#this code only shows if a position at the desk is available for spawning an item or not
class_name CounterPOS

var empty = true

func get_empty():
	return empty

func set_empty(e):
	empty = e
