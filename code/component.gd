extends Area3D

class_name Component
#if it needs a specific tool in order to fix, get the name from the tool itself
@export var needs_tool = "tool"
#potential issues
var issues = ["needs fixing"]
#the issue that it currently has (only one at a time ffor noew)
var issue
#if the user can interact with the item
@export var interactible = true

#check if the component can interact
func get_interactible():
	return interactible

func set_interactible(interact):
	interactible = interact

func get_issue():
	return issue

func set_issue(i):
	issue = i
	
#pick a random issue from the array of issues
func pick_issue():
	var i = issues[randi_range(0, len(issues)-1)]
	print(i)
	set_issue(i)
