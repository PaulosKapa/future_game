extends RigidBody3D

class_name Door
#checkk if we can interact with the door
@export var interactible = true
#the hinge
@export var hinge : HingeJoint3D

#if the door is closed
var closed = true
#check if the counter can interact

func get_interactible():
	return interactible

func set_interactible(interact):
	interactible = interact
	
func get_closed():
	return closed
func set_closed(c):
	closed = c

#when the player touches the door to open it
func open_door():
	#disable the motor
	hinge.set_flag(HingeJoint3D.FLAG_ENABLE_MOTOR, false) 
	#set the limits to -90 and 90
	hinge.set_param(HingeJoint3D.PARAM_LIMIT_LOWER, deg_to_rad(-90))
	hinge.set_param(HingeJoint3D.PARAM_LIMIT_UPPER, deg_to_rad(90))
	#set the state of the door to open
	set_closed(false)

#when the player presses e to close the door
func close_door():
	#get the current angle
	var current_angle = rotation.y
	#enable motor and set impulse   
	hinge.set_flag(HingeJoint3D.FLAG_ENABLE_MOTOR, true)
	hinge.set_param(HingeJoint3D.PARAM_MOTOR_MAX_IMPULSE, 10.0)
	#always close the door torwards the frame
	if current_angle > 0:
	
		hinge.set_param(HingeJoint3D.PARAM_LIMIT_LOWER, 0)
		hinge.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY, -3.0)
	else:
	
		hinge.set_param(HingeJoint3D.PARAM_LIMIT_UPPER, 0)
		hinge.set_param(HingeJoint3D.PARAM_MOTOR_TARGET_VELOCITY, 3.0)
	#set the state as closed
	set_closed(true)

#will only be true if the user pushes the door
func _on_area_3d_body_entered(body):
	if(body is CharacterBody3D):
		open_door()
