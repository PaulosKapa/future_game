extends Node3D

var items_on_hands: Node3D = null

#holster is for when picking an item. probably should change the logic when armature is implemented
@export var holster: Node3D
#for the raycast
@export var eyes: RayCast3D

# Called when the node enters the scene tree for the first time.
func _ready():
	#connect the emiters
	eyes.pick.connect(_on_item_picked)
	eyes.drop.connect(_on_item_dropped)
	eyes.put.connect(_on_counter_put)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

#set and get if the user has an item on their hand
func get_item_on_hands():
	return items_on_hands
func set_item_on_hands(items):
	items_on_hands = items

#when you pick up an item
func pick_up_item(_item: Node3D):
	if(get_item_on_hands() == null):
		#reparent it to the holster
		_item.get_parent().reparent(holster)
		#set the position and rotation the same as the holster
		_item.position = Vector3.ZERO
		_item.rotation = Vector3.ZERO
		#disable physics collisions
		_item.freeze = true
		#disable raycast collisions
		_item.get_child(0).set_deferred("disabled", true)
		#so it can't be pick up while on your hand
		_item.set_interactible(false)
		set_item_on_hands(_item)
		print(_item)
func _on_item_picked(_item: Node3D):
	print("hi")
	pick_up_item(_item)

#for dropping the item
func drop_item(_item: Node3D):
	#if they have something on hand
	if(get_item_on_hands() != null):
		#just reparent to the scene
		var world_node = get_tree().current_scene
		_item.get_parent().reparent(world_node)
		#enable physics collisions
		_item.freeze = false
		#enablle raycast collisions
		_item.get_child(0).set_deferred("disabled", false)
		_item.set_interactible(true)
		set_item_on_hands(null)
		print(item)

func _on_item_dropped():
	drop_item(get_item_on_hands())
	
#for putting stuff to counter
func _on_counter_put(_counter: Node3D):
	#if there is something on the character's hands
	if(get_item_on_hands() !=null ):
		#add the item from the hands to the counter
		_counter.not_empty_POS.append(_counter.spawn_item(get_item_on_hands()))
		set_item_on_hands(null)
