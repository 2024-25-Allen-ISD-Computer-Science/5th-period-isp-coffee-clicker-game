class_name Building
extends Resource

# buildings alter the production of various resources throughout the game, based on their position
# on the map. 

var position_type: int # where the building must be positioned to function (2-8 must be ordered easiest to hardest)
	# 0: nowhere (reserved for empty spaces)
	# 1: also nowhere (reserved for the coffee stand)
	# 2: anywhere
	# 3: outer rim (any space at the very edge of the grid)
	# 4: rook (any space to the direct N/E/S/W of the stand)
	# 5: bishop (any space diagonal to the stand)
	# 6: king (any space adjacent to the stand)
	# 7: knight (any space that forms an L with the stand)
	# 8: isolate (must have empty space all around)
var bean_type: int # which bean the building affects
var multiplier: float

func _init(position_type: int = 0, bean_type: int = 0, offset: float = 0.0) -> void:
	self.position_type = position_type
	self.bean_type = bean_type
	self.multiplier = calc_multiplier()

# calculates the strength of the building's multiplier
func calc_multiplier(benefit: bool = true) -> float:
	if position_type < 2:
		return 1
	var position_mult = 0.25 / (9 - position_type) # trickier position types -> stronger effects
	print(position_mult)
	var bean_mult = 0.65 / (bean_type + 1) # more valuable beans -> weaker effects
	print(bean_mult)
	if benefit:
		return 0.1 + position_mult + bean_mult + 1.0
	else:
		return 0.1 + position_mult + bean_mult

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
