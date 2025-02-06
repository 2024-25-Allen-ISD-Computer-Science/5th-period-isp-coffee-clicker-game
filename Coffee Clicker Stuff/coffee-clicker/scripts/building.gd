class_name Building
extends Resource

# buildings alter the production of various resources throughout the game, based on their position
# on the map. 

var position_type: int # where the building must be positioned to function
	# 0: nowhere (reserved for empty spaces)
	# 1: also nowhere (reserved for the coffee stand)
	# 2: anywhere
	# 3: king (any space adjacent to the stand)
	# 4: rook (any space to the direct N/E/S/W of the stand)
	# 5: bishop (any space diagonal to the stand)
	# 6: knight (any space that forms an L with the stand)
	# 7: outer rim (any space at the very edge of the grid)
	# 8: isolate (must have empty space all around)
var bean_type: int # which bean the building affects
var multiplier: int 

func _init(position_type: int = 0, bean_type: int = 0, multiplier: int = 1) -> void:
	self.position_type = position_type
	self.bean_type = bean_type
	self.multiplier = multiplier

# returns the parameters that make up this building's attributes
func params() -> Dictionary:
	var params = {}
	params["position_type"] = self.position_type
	params["bean_type"] = self.bean_type
	params["multiplier"] = self.multiplier
	return params

# adjusts this building's attributes based on new parameters
func define(params: Dictionary) -> void:
	position_type = params["position_type"]
	bean_type = params["bean_type"]
	multiplier = params["multiplier"]

# resets a building's attributes to an empty space's
func reset() -> void:
	position_type = 0
	bean_type = 0
	multiplier = 1
