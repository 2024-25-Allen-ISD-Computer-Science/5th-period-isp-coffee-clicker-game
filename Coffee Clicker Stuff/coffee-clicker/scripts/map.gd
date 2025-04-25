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
var multipliers: int = 1 # array of each bean's multiplier. 1 is appended when a new bean is unlocked
#var available_builds = [] # contains the ids of any buildings that haven't yet been placed
var placed_builds = [] # contains the ids of current placed buildings

func _init(grid: Array) -> void:
	grid = self.grid
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

# counts how many buildings of a given pos-type exist on the grid
func count_if(position_type: int) -> int:
	var count = 0
	for x in range(grid.size()):
		var x_strip: Array = grid[x]
		for y in range(x_strip.size()):
			var y_cell: Building = x_strip[y]
			if y_cell.position_type == position_type:
				count += 1
	return count

# places an UNPLACED building at the specified location 
func place(build_id: Dictionary, x: int, y: int) -> void:
	var target: Building = grid[x][y]
	if target.position_type == 1:
		return # can't remove the stand
	if target.position_type != 0:
		remove(x, y)
	target.define(build_id)
	placed_builds.append(build_id)
#	available_builds.erase(build_id)
	update_multipliers()

# moves a PLACED building from one location to another, swapping places with obstructions if
# necessary
func move(x: int, y: int, X: int, Y: int) -> void:
	var from: Building = grid[x][y]
	var to: Building = grid[X][Y]
	if from.position_type == 0:
		return # doesn't make sense to be interacting with nothing, but this could be removed
	if to.position_type == 0: # moving building to an empty space; doesn't need temporary variables
		to.define(from.params())
		from.reset()
	else:
		var to_temp = to.params()
		to.define(from.params())
		from.define(to_temp)

# removes a building (if any) from the specified location
func remove(x: int, y: int) -> void:
	var target: Building = grid[x][y]
	if target.position_type <= 1:
		return # can't remove empty space or the stand
#	available_builds.append(target.params())
	placed_builds.erase(target.params())
	target.reset()
	update_multipliers()

# returns whether the specified location has no neighbors
func alone_at(x: int, y: int) -> bool:
	for x_neighbor in range(x - 1, x + 2):
		if x_neighbor < 0 or x_neighbor >= grid.size():
			continue
		for y_neighbor in range(y - 1, y + 2):
			if y_neighbor < 0 or y_neighbor >= grid[x_neighbor].size():
				continue
			if x_neighbor == x and y_neighbor == y:
				continue
			var cell: Building = grid[x_neighbor][y_neighbor]
			if cell.position_type != 0:
				return false
	return true

# parses through grid and checks which spaces contain the correct building (if any). then includes
# each valid building's multiplier in the array
func update_multipliers() -> void:
	for x in range(grid.size()):
		var x_strip: Array = grid[x]
		for y in range(x_strip.size()):
			var y_cell: Building = x_strip[y]
			if check_position(y_cell.position_type, x, y):
				multipliers *= y_cell.multiplier

# determines if a building is correctly positioned based on its position type
func check_position(position_type: int, x: int, y: int, X: int = origin()[0], Y: int = origin()[1]) -> bool:
	match position_type:
		0: return false
		1: return false
		2: return true # anywhere
		3: return x in [0, grid.size() - 1] or y in [0, grid[x].size() - 1] # outer rim
		4: return x == X or y == Y # rook
		5: return abs(x - X) == abs(y - Y) # bishop
		6: return abs(x - X) <= 1 and abs(y - Y) <= 1 # king
		7: return (abs(x - X) == 1 and abs(y - Y) == 2) or (abs(x - X) == 2 and abs(y - Y) == 1) # knight
		8: return alone_at(x, y) # isolate
		_: push_error("Type does not exist"); return false
