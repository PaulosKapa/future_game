extends RayCast3D
#signals for dropping and picking up items
signal pick
signal drop
signal put
signal repair
signal component_interaction
signal tooling

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
			if(collider is ToolItem):
				if(Input.is_action_just_pressed("user_interact")):
					#emit tooling
					tooling.emit(collider)
			#for different types 
			elif(collider is Item):
				if(Input.is_action_just_pressed("user_interact")):
					#emit pick
					pick.emit(collider)
					
			elif(collider is Repairs):
				if(Input.is_action_just_pressed("user_interact")):
					#emit repair
					repair.emit(collider)
					
			elif(collider is Counter):
				
				if(Input.is_action_just_pressed("user_interact")):
					#emit put
					put.emit(collider)
					
			elif(collider is Component):
				
				if(Input.is_action_just_pressed("user_interact")):
					#emit put
					component_interaction.emit(collider)
				
			

	#if user_drop is pressed emit drop. Not necesary to call from a raycast
	if(Input.is_action_just_pressed("user_drop")):
		drop.emit()
			
