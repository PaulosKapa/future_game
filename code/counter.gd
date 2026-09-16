extends StaticBody3D

class_name Counter

#checkk if we can interact with the counter
@export var interactible = true
#positions that items can spawn
@export var ItemPOS: Array[Node3D]
#check if the counter is for repairing items
@export var is_repair = false

var not_empty_POS: Array[Node3D]

# Called when the node enters the scene tree for the first time.
func _ready():
	#check if there are any itemmpos that arent empty
	for POS in ItemPOS:
		if POS.get_child_count()>0:
			#if they arent empty then set them as that and add to the not empty list
			POS.set_empty(false)
			not_empty_POS.append(POS)
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#check if there are any items that got remoe
	remove_item()

#check if the counter can interact
func get_interactible():
	return interactible

func set_interactible(interact):
	interactible = interact
	


#for spawning an item
func spawn_item(new_item):
	for POS in ItemPOS:
		#if there is any empty itempos spawn the item there
		if POS.get_empty()==true:
			#for placing items to the counter
			if(new_item.get_parent()!=null):
				var root = new_item.get_parent()
				root.reparent(POS)
				#set the position and rotation the same as the ItemPOS
				root.position = Vector3.ZERO
				root.rotation = Vector3.ZERO
				return POS
			#for directly spawning
			else:
				POS.add_child(new_item)
			#it int empty anymore
			POS.set_empty(false)
			return POS
	return null


func remove_item():
	for POS in not_empty_POS:
		if POS.get_child_count()==0:
			POS.set_empty(true)
			not_empty_POS.remove_at(not_empty_POS.find(POS))
