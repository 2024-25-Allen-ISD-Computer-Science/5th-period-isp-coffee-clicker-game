class_name grid_block
extends Node2D

# grid block properties
@export var x_coord : int
@export var y_coord : int
@export var width : int
@export var building : Building
@export var active : bool

func _init(x_coord : int, y_coord : int, building : Building, active : bool) -> void:
	self.x_coord = x_coord
	self.y_coord = y_coord
	self.building = building
	self.active = active

# function to check if the mouse is in the location of the specified grid block
# will be used in onevent when mouse is clicked and taken the global mouse position during that instance
func _in_loc(loc_mouse : Vector2i) -> bool:
	return loc_mouse.y in range(y_coord, y_coord + width) and loc_mouse.x in range(x_coord, x_coord + width)

func 
