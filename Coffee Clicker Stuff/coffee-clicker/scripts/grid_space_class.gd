class_name grid_block
extends Node2D

# grid block properties
@export var width : int
@export var building : Building
@export var node : TextureButton
var x_coord : int
var y_coord : int 

func _init(building : Building, node : TextureButton) -> void:
	self.building = building
	self.node = node
	x_coord = Vector2i(node.global_position).x
	y_coord = Vector2i(node.global_position).y
	width = int(Vector2i(node.texture_normal.get_width() * node.scale).x)

# function to check if the mouse is in the location of the specified grid block
# will be used in onevent when mouse is clicked and taken the global mouse position during that instance
func _in_loc(loc_mouse : Vector2i) -> bool:
	return loc_mouse.y in range(y_coord, y_coord + width) and loc_mouse.x in range(x_coord, x_coord + width)

func _change_building(new_building : Building):
	building = new_building
	node.texture = building.texture
