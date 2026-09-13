extends counter

@onready var _counter = load("res://scenes/item.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	var new_item = _counter.instantiate()
	#print("child")
	not_empty_POS.append(spawn_item(new_item))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	super(delta)
	#print(not_empty_POS)
