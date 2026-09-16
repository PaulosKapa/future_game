extends Node3D

#for the raycast

@export var inventory: Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.eyes.repair.connect(_on_counter_interact)
	inventory.eyes.component_interaction.connect(_on_component_interact)
	inventory.eyes.tooling.connect(_on_tool_pick)
	
#this works only when interacting with a repair desk
func _on_counter_interact(_counter: Node3D):
		#for when put on a repair desk
		if(inventory.get_item_on_hands()!=null):
			if(inventory.get_item_on_hands() != ToolItem and inventory.get_item_on_hands().can_change):
				if(_counter.get_init_repairing() == false):
					print(inventory.get_item_on_hands())
					inventory.get_item_on_hands().set_interactible(true)
					#add the item from the hands to the counter
					_counter.not_empty_POS.append(_counter.spawn_item(inventory.get_item_on_hands()))

					inventory.get_item_on_hands().set_repairing(true)
					#change wheter or not you can see the repair or the item
					inventory.get_item_on_hands().get_parent().set_repairing_visuals()
					#begin the repairing process
					_counter.set_init_repairing(true)
					#disable raycast collisions sso the user can pick the innner components
					inventory.get_item_on_hands().get_child(0).set_deferred("disabled", true)
					inventory.set_item_on_hands(null)
				
		#this is for finishing the repair
		else:
			if(_counter.get_init_repairing()):
				_counter.end_repairs()

#for interacting with a component
func _on_component_interact(_component: Node3D):

	if(_component.needs_tool!=null):
		
		if(inventory.get_item_on_hands() && inventory.get_item_on_hands().item_name==_component.needs_tool):
			
			#get the item manager and subtract 1 from the issues
			var item_parent = _component.get_parent().get_parent().get_parent().get_parent()
			if(_component.get_issue()!=null):
				item_parent.set_number_of_issues(item_parent.get_number_of_issues() - 1)
				#the component is fixed
				_component.set_issue(null)
				print(item_parent.get_number_of_issues())
			
func _on_tool_pick(_item):
	var root = _item.get_parent()
	_item.linear_velocity = Vector3.ZERO
	_item.angular_velocity = Vector3.ZERO
	#disable physics collisions
	_item.freeze = true
	#reparent it to the holster
	root.reparent(inventory.holster)
	#set the position and rotation the same as the holster
	root.position = Vector3.ZERO
	root.rotation = Vector3.ZERO
	#set the item's pos and rot the same as the node3d parent
	_item.position = Vector3.ZERO
	_item.rotation = Vector3.ZERO
	#disable raycast collisions
	_item.get_child(0).set_deferred("disabled", true)
	#so it can't be pick up while on your hand
	_item.set_interactible(false)
	inventory.set_item_on_hands(_item)
	print("hm")
