extends Node3D


#get the player's inventory
@export var inventory: Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	#connect the emiters
	inventory.eyes.pick.connect(_on_item_picked)
	inventory.eyes.drop.connect(_on_item_dropped)
	inventory.eyes.put.connect(_on_counter_put)





#when you pick up an item
func pick_up_item(_item: Node3D):
	if(inventory.get_item_on_hands() == null):
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
		print(_item)
		
func _on_item_picked(_item: Node3D):
	pick_up_item(_item)

#for dropping the item
func drop_item(_item: Node3D):
	#if they have something on hand
	if(inventory.get_item_on_hands() != null and _item is RigidBody3D):
		
		#just reparent to the scene
		var world_node = get_tree().current_scene
		_item.get_parent().reparent(world_node)
		##uncomment if there are bugs later. for now it works the sameww
		#get the current pos and rot of the item
		#var current_global_transform = _item.global_transform
		## 3. Move the root exactly to where the RigidBody currently is
		#item_root.global_transform = current_global_transform
		## 4. Zero out the RigidBody's local offset so they stay perfectly together
		#_item.position = Vector3.ZERO
		#_item.rotation = Vector3.ZERO
		#enable physics collisions
		_item.freeze = false
		#enablle raycast collisions
		_item.get_child(0).set_deferred("disabled", false)
		_item.set_interactible(true)
		inventory.set_item_on_hands(null)
		print(_item)

func _on_item_dropped():
	drop_item(inventory.get_item_on_hands())
	
#for putting stuff to counter
func _on_counter_put(_counter: Node3D):
	#if there is something on the character's hands and there is empty space on the counter
	if(inventory.get_item_on_hands() !=null && len(_counter.ItemPOS)> len(_counter.not_empty_POS)):
		
		inventory.get_item_on_hands().freeze = true
		#enablle raycast collisions
		inventory.get_item_on_hands().get_child(0).set_deferred("disabled", false)
		inventory.get_item_on_hands().set_interactible(true)
		#add the item from the hands to the counter
		_counter.spawn_item(inventory.get_item_on_hands())
		inventory.set_item_on_hands(null)
