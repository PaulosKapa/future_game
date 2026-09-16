extends Counter

class_name Repairs

var repairing = false

#for knowing if the counter is used for repairing stuff or not
func get_init_repairing():
	return(repairing)
	
func set_init_repairing(r):
	repairing = r

#make the item interactible again by enabling the collision shape
func end_repairs():
	print(ItemPOS[0].get_child(0).get_child(0).get_child(0))
	ItemPOS[0].get_child(0).get_child(0).get_child(0).set_deferred("disabled", false)
	ItemPOS[0].get_child(0).get_child(0).set_repairing(false)
	ItemPOS[0].get_child(0).set_repairing_visuals()
	#stop the repairing process
	set_init_repairing(false)
