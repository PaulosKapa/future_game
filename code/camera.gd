extends Node3D
#basic camera implementation
var camera_x_rotation = 0
var mouse_sensitivity = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
func _input(event):
	if event is InputEventMouseMotion:
		get_parent().rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
		var x_delta = event.relative.y * mouse_sensitivity 
		
		if camera_x_rotation + x_delta> -90 and camera_x_rotation + x_delta < 90:
			self.rotate_x(deg_to_rad(-x_delta))
			camera_x_rotation += x_delta
