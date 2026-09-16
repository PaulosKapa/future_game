extends RigidBody3D
class_name Item
#if the user can interact with the item
@export var interactible = true
#if the user repairs the item
@export var repairing = false
#if the item needs repair
@export var needs_repair = true
#item name
@export var item_name = "item"
#if an item can upgrade/repai
@export var can_change = true

func get_interactible():
	return interactible

func set_interactible(interact):
	interactible = interact

func get_repairing():
	return repairing

func set_repairing(r):
	repairing = r

func get_needs_repair():
	return needs_repair

func set_needs_repair(r):
	needs_repair = r
