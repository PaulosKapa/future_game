extends Node3D

#get the player's inventory
@export var inventory: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	#connect the emiters
	inventory.eyes.open_door.connect(_on_door_open)

#ffor closing the door
func _on_door_open(_door: Node3D):
	if(!_door.get_closed()):
		_door.close_door()
