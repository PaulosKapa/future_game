extends RayCast3D
#signals for dropping and picking up items
signal pick
signal drop
signal put

# Called when the node enters the scene tree for the first time.
func _ready():
	#in order to be able to pick up Area3D
	collide_with_areas = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#if the raycast is colliding
	if(is_colliding()):
		var collider = get_collider()
		#if you can interact
		if(collider.has_method("get_interactible") && collider.get_interactible()):
			#if user_interact is pressed
			
			#for different types 
			if(collider is item):
				if(Input.is_action_just_pressed("user_interact")):
					#emit pick
					pick.emit(collider)
			elif(collider is counter):
				if(Input.is_action_just_pressed("user_interact")):
					#emit put
					put.emit(collider)
						
	#if user_drop is pressed emit drop. Not necesary to call from a raycast
	if(Input.is_action_just_pressed("user_drop")):
		drop.emit()
			
