extends Node3D

#holster is for when picking an item. probably should change the logic when armature is implemented
@export var holster: Node3D
#for the raycast
@export var eyes: RayCast3D

var items_on_hands: Node3D = null

#set and get if the user has an item on their hand
func get_item_on_hands():
	return items_on_hands
func set_item_on_hands(items):
	items_on_hands = items
