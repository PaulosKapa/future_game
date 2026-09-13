extends RigidBody3D
class_name item
#if the user can interact with the item
@export var interactible = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func get_interactible():
	return interactible

func set_interactible(interact):
	interactible = interact
