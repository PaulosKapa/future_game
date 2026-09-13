extends Node3D
#load the player scene
@onready var player_scene = preload("res://scenes/character.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#instance the player scene
	var player = player_scene.instantiate()
	add_child(player)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
