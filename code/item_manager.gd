extends Node3D

@export var active_item: RigidBody3D
@export var item_for_repair: Node3D
@export var spawners: Array[Node3D]
#how many issues the item has
var errors = 0
#check what components the item consists of. These can change with item updates (to do later)
var components = [Globals.test_component]
#for spawned components
var spawned_components: Array[Node3D]

func _ready():
	var i = 0
	#if the itemm needs repair or not. leave it true for now
	active_item.set_needs_repair(true)

	for spawner in spawners:
		var spawned_item = components[i].instantiate()
		spawner.add_child(spawned_item)
		spawned_components.append(spawned_item)
		i+=1
	#add each component to the specific spawner
	i = 0
	for c in spawned_components:
		c.get_child(0).pick_issue()
		if(active_item.get_needs_repair()):
			set_number_of_issues(i+1)
	active_item.set_repairing(false)
	set_repairing_visuals()

func set_repairing_visuals():
	#when repairing item hide and disable the regular item
	if(active_item.get_repairing()):
		active_item.hide()
		active_item.process_mode = Node.PROCESS_MODE_DISABLED
		item_for_repair.show()
		item_for_repair.process_mode = Node.PROCESS_MODE_INHERIT
	#when not repairing item hide and disable the repairable item
	else:
		active_item.show()
		active_item.process_mode = Node.PROCESS_MODE_INHERIT
		item_for_repair.hide()
		item_for_repair.process_mode = Node.PROCESS_MODE_DISABLED

func get_number_of_issues():
	return errors

func set_number_of_issues(i):
	errors = i
