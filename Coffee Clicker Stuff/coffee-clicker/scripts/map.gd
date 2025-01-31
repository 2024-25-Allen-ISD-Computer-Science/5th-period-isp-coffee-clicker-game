class_name Map
extends Resource

# the map contains the positions of buildings and the coffee stand, determining which buildings are
# where in order to calculate additional factors to bean production

var grid = [[Building.new(0), Building.new(0), Building.new(0), Building.new(0), Building.new(0)],
			[Building.new(0), Building.new(0), Building.new(0), Building.new(0), Building.new(0)],
			[Building.new(0), Building.new(0), Building.new(1), Building.new(0), Building.new(0)],
			[Building.new(0), Building.new(0), Building.new(0), Building.new(0), Building.new(0)],
			[Building.new(0), Building.new(0), Building.new(0), Building.new(0), Building.new(0)]] 
			# the 5x5 map containing all spaces. the x axis increases from top to bottom, while the
			# y axis increases from left to right
var multipliers = [1] # array of each bean's multiplier. 1 is appended when a new bean is unlocked
var available_builds = [] # contains the ids of any buildings that haven't yet been placed
var placed_builds = [] # contains the ids of current placed buildings

# returns the index combination locating the coffee stand
func origin() -> Array:
	for x in range(grid.size()):
		var x_strip: Array = grid[x]
		for y in range(x_strip.size()):
			var y_cell: Building = x_strip[y]
			if y_cell.position_type == 1:
				return [x, y]
	push_error("Coffee stand not found on grid.")
	return []

# places a building at the specified location 
func place(build_id: Dictionary, x: int, y: int) -> void:
	var target: Building = grid[x][y]
	if target.position_type == 1:
		return
		# READ THIS! # 
			# may need an indication somewhere that the stand can't be replaced like this
		# READ THIS! #
	if target.position_type != 0:
		remove(x, y)
	target.define(build_id)
	placed_builds.append(build_id)
	available_builds.erase(build_id)
	update_multipliers()

# removes a building (if any) from the specified location
func remove(x: int, y: int) -> void:
	var target: Building = grid[x][y]
	match target.position_type:
		0: return # can't remove a building that isn't there
		1: return # can't remove the coffee stand from the map
			# READ THIS! # 
				# may need an indication somewhere that the stand can't be replaced like this
			# READ THIS! #
		_:
			available_builds.append(target.params())
			placed_builds.erase(target.params())
			target.reset()
			update_multipliers()

# parses through grid and checks which spaces contain the correct building (if any). then includes
# each valid building's multiplier in the array
func update_multipliers() -> void:
	for x in range(grid.size()):
		var x_strip: Array = grid[x]
		print("ROW %s" % x)
		for y in range(x_strip.size()):
			var y_cell: Building = x_strip[y]
			if check_position(y_cell.position_type, x, y):
				print("Type %s At grid[%s][%s] in place!" % [y_cell.position_type, x, y], )
				multipliers[y_cell.bean_type] *= y_cell.multiplier
			else:
				print("Type %s At grid[%s][%s] not in place or not counted." % [y_cell.position_type, x, y], )

# determines if a building is correctly positioned based on its position type
func check_position(position_type: int, x: int, y: int, X: int = origin()[0], Y: int = origin()[1]) -> bool:
	match position_type:
		0: return false
		1: return false
		2: return true
		3: return abs(x - X) <= 1 and abs(y - Y) <= 1
		4: return x == X or y == Y
		5: return abs(x - X) == abs(y - Y)
		6: return (abs(x - X) == 1 and abs(y - Y) == 2) or (abs(x - X) == 2 and abs(y - Y) == 1)
		_: push_error("Type does not exist"); return false
