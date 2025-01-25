class_name Massint
extends Resource

# the massint system is a method of writing numbers such that values higher than 2^63-1 (godot's
# integer limit) can be a part of our project. massints are arrays of 3 digit numbers (referred to 
# as "triplets" in the code) ordered from least to most significant in order to represent massive
# unsigned integers.
# for example: 28,572,957 = [957, 572, 28]

# properties of massint
@export var value: Array
@export var suffixes: Array

func _init(value: Variant = []):
	assign(value)



#>---INITIALIZATION---<#

# used with ints or massints to reassign its value
func assign(value: Variant):
	assert(value is int or value is Array, "ERROR: Massints must be initialized or reassigned using either int or Array. %s is neither" % str(value)) # flexible to either massints or integers
	if value is int:
		assert(value >= 0, "ERROR: Massints are unsigned. The supplied integer (%s) must be nonnegative" % value)
		self.value = massify(value)
	else: 
		self.value = value
		if self.value == []:
			self.value = [0]
		if triplets() >= 1:
			assert(value[triplets() - 1] >= 0, "ERROR: Massints are unsigned. The last triplet (%s) must be nonnegative" % value[triplets() - 1])
	self.suffixes = ["", "", "K", "M", "B", "T", "Qa", "Qt", "Sx", "Sp", "Oc", "No", "Dc"] # two empty strings addressed to 0 and 1-999
	grow() # in case of improper format
	regroup() # in case of improper values

#>---INITIALIZATION---<#



#>---INPUT HANDLING---<#

# converts an integer to a massint-formatted array
func massify(input: int) -> Array:
	if input == 0:
		return [0] # no need to resolve 0
	var sequence = input
	var output: Array = []
	while sequence > 0:
		var triplet = sequence % 1_000 # calculates the part of sequence lower than 1,000
		output.append(triplet)
		sequence /= 1_000 # removes the 3 least significant digits for the next triplet
	return output

#>---INPUT HANDLING---<#



#>---STRING HANDLING---<#

# returns a condensed (if necessary) string of the number
func condensed() -> String:
	if triplets() >= suffixes.size():
		return e_notation()
	var first = str(value[triplets() - 1]) # triplets() is the SIZE of the number, not its LAST INDEX
	if triplets() < 2: # returns early if too small to be condensed
		return first
	var second = str(value[triplets() - 2]) # likewise
	if second != "0":
		second = lead_zeroes(second)
		second = trail_zeroes(second)
	var output = "%s.%s" % [first, second] + suffixes[triplets()]
	return output

# formats smaller numbers for condensed()
func lead_zeroes(input: String) -> String:
	var output = input
	while output.length() < 3:
		output = "0" + output # adds zeroes to the beginning of the string for correct placement (i.e [1, 1, 0] should be "1.001K" and not "1.1K")
	return output

# formats larger numbers for condensed()
func trail_zeroes(input: String) -> String:
	return input.rstrip("0") # removes trailing zeroes from the end of the string (i.e. [100, 1, 0] should be "1.1K" and not "1.100K")

# failsafe; converts number into e notation if too large for a suffix
func e_notation() -> String:
	var first = (value[triplets() - 1]) * 1_000
	var second = value[triplets() - 2]
	var num = float(first) + float(second)
	var e_plus = str(exact() - 1)
	num /= 10 ** (str(num).length() - 1)
	var output = str(num)
	output = output.substr(0, 5) + "e+" + e_plus 
	return output

#>---STRING HANDLING---<#



#>---ARITHMETIC HANDLING---<#

# measures size of the represented number in triplets
func triplets() -> int:
	for largest in range(value.size() - 1, -1, -1): # starts at the most significant triplet
		if value[largest] != 0:
			return largest + 1 # incremented by 1 to measure size, since the ones-to-hundreds triplet is at index 0, thousands-to-hundred-thousands at index 1, etc.
	return 0

# measures exact number of digits
func exact() -> int:
	return (triplets() - 1) * 3 + str(value[triplets() - 1]).length()

# adds a leading zero if there are none, to ensure no errors during arithmetic
func grow() -> void:
	if triplets() == value.size(): # [1] is not optimal
		value.append(0) # [1, 0] is optimal

# removes extra leading zeroes so that only one succeeds the last value
func shrink() -> void:
	while value.size() - 1 != triplets():
		value.pop_back()

# either borrows or carries numbers based on whether below or above 000-999
func regroup() -> void:
	var index = 0
	while index != value.size():
		grow() # ensuring space for regrouping operations
		if value[index] < 0: # below - borrowing
			var deficit = abs(value[index]) + 1000 - ((abs(value[index]) + 1000) % 1_000)
			value[index + 1] -= deficit / 1_000 # this value...
			value[index] += deficit # is 1,000 times larger in the previous triplet
		elif value[index] > 999: # above + carrying
			var excess = value[index] - (value[index] % 1_000) # represents how far over 999
			value[index] -= excess # this value...
			value[index + 1] += excess / 1_000 # is 1,000 times smaller in the next triplet
		index += 1
	grow() # in case any 1s are carried into the last index
	shrink() # in case there's more leading zeros than necessary

# adds a massint to another massint
func add(addend: Variant) -> void:
	assert(addend is int or addend is Massint, "ERROR: Addends must be either int or massint. %s is neither" % addend)
	if addend is int:
		if addend == 0:
			return # A + 0 = A
		self.add(Massint.new(addend))
	else:
		if addend.equal(0):
			return # A + 0 = A
		var common_size: int = self.triplets() # determines where parsing between arrays MUST stop before an error occurs
		var result: Array = []
		if addend.less(self): # common_size is influenced by the smaller massint
			common_size = addend.triplets()
		for index in range(common_size):
			result.append(self.value[index] + addend.value[index]) # sums are made and then appended to result
		if self.greater(addend):
			result += self.value.slice(common_size, self.triplets()) # analogous to adding the larger massint's values to the smaller's leading zeroes
		elif addend.greater(self):
			result += addend.value.slice(common_size, addend.triplets()) # likewise
		self.value = result 
		regroup() # handling values in the thousands place

# subtracts a massint from another massint. as massints are unsigned, errors will occur if subtrahend > minuend
func subtract(subtrahend: Variant) -> void:
	assert(subtrahend is int or subtrahend is Massint, "ERROR: Subtrahends must be either int or massint. %s is neither" % subtrahend)
	if subtrahend is int:
		if subtrahend == 0:
			return # A - 0 = A
		self.subtract(Massint.new(subtrahend))
	else:
		if subtrahend.equal(0):
			return # A - 0 = A
		if self.equal(subtrahend):
			self.value = [0] # A - A = 0
			return
		assert(!self.less(subtrahend), "ERROR: Massints are unsigned. %s - %s would result in a negative number" % [self.condensed(), subtrahend.condensed()])
		var common_size: int = self.triplets() # determines where parsing between arrays MUST stop before an error occurs
		var result: Array = []
		if subtrahend.less(self): # common_size is influenced by the smaller massint
			common_size = subtrahend.triplets()
		for index in range(common_size):
			result.append(self.value[index] - subtrahend.value[index]) # differences are made and then appended to result
		if subtrahend.less(self): # common_size is influenced by the smaller massint
			result += self.value.slice(common_size, self.triplets()) # analogous to subtracting the smaller's leading zeroes from the larger massint's values
		self.value = result
		regroup() # handling negative values

# multiplies a massint by a massint/int (separate, type-based processes unlike the previous two)
func multiply(multiplier: Variant) -> void:
	assert(multiplier is int or multiplier is Massint, "ERROR: Multipliers must either be int or massint. %s is neither" % multiplier)
	if multiplier is int:
		assert(multiplier >= 0, "ERROR: Massints are unsigned. %s * %s would result in a negative number" % [self.condensed(), multiplier])
		if multiplier == 0:
			self.value = [0] # A * 0 = 0
			return
		if multiplier == 1:
			return # A * 1 = A
		var result: Array = []
		for index in range(self.triplets()):
			result.append(self.value[index] * multiplier) # somewhat like long multiplication, except the factor is broken up into triplets rather than digits
		self.value = result
		regroup() # handling numbers in the thousands place and higher
	else:
		if multiplier.equal(0): # zero property of multiplication
			self.value = [0]
			return
		elif multiplier.equal(1): # identity property of multiplication
			return
		else:
			var result: Array = []
			if self.less(multiplier): # multiplies by the smaller factor
				for mult_index in range(self.triplets()):
					var current_result: Array = []
					for place in range(mult_index):
						current_result.append(0) # moves up a place value each iteration
					for index in range(multiplier.triplets()):
						current_result.append(multiplier.value[index] * self.value[mult_index]) # same "long multiplication" concept
					result = array_add(result, current_result) # adding up the subproducts to make the final product - also similar to long multiplication
			else:
				for mult_index in range(multiplier.triplets()):
					var current_result: Array = []
					for place in range(mult_index):
						current_result.append(0) # moves up a place value each iteration
					for index in range(self.triplets()):
						current_result.append(self.value[index] * multiplier.value[mult_index]) # same "long multiplication" concept
					result = array_add(result, current_result) # adding up the subproducts to make the final product - also similar to long multiplication
			self.value = result
			regroup() # handling numbers in the thousands place and higher

# returns an array of the sums of two other arrays
func array_add(addend1: Array, addend2: Array) -> Array:
	if addend1.size() != addend2.size(): # ensures one array's addends have a place with the other array's addends
		if addend1.size() > addend2.size():
			while addend1.size() > addend2.size():
				addend2.append(0)
		else:
			while addend1.size() < addend2.size():
				addend1.append(0)
	var sum: Array = []
	for index in addend1.size():
		sum.append(addend1[index] + addend2[index])
	return sum

#>---ARITHMETIC HANDLING---<#



#>---COMPARISON/INEQUALITY---<#

# 3 return cases
func greater(than: Variant) -> bool:
	assert(than is int or than is Massint, "ERROR: Comparees must be either int or massint. %s is neither" % than)
	if than is int:
		return self.greater(Massint.new(than))
	else:
		if self.triplets() != than.triplets(): #1. different sizes (size-wise)
			return self.triplets() > than.triplets()
		for index in range(self.triplets() - 1, -1, -1): #2. same sizes (element-wise, starting from most significant digits)
			if self.value[index] != than.value[index]:
				return self.value[index] > than.value[index]
		return false #3. identical (false)

# same as greater(than) but reversed
func less(than: Variant) -> bool:
	assert(than is int or than is Massint, "ERROR: Comparees must be either int or massint. %s is neither" % than)
	if than is int:
		return self.less(Massint.new(than))
	else:
		if self.triplets() != than.triplets(): #1. different sizes (size-wise)
			return self.triplets() < than.triplets()
		for index in range(self.triplets() - 1, -1, -1): #2. same sizes (element-wise, starting from most significant triplets)
			if self.value[index] != than.value[index]:
				return self.value[index] < than.value[index]
		return false #3. identical (false)

# same as previous two but equality
func equal(to: Variant) -> bool:
	assert(to is int or to is Massint, "ERROR: Comparees must be either int or massint. %s is neither" % to)
	if to is int:
		return self.equal(Massint.new(to))
	else:
		if self.triplets() != to.triplets(): #1. different sizes (false)
			return false
		for index in range(self.triplets() - 1, -1, -1): #2. same sizes (element-wise, starting from most significant triplets)
			if self.value[index] != to.value[index]:
				return false
		return true #3. identical (true)
	# return !greater(to) && !less(to)

# opposite of equal
func unequal(to: Variant) -> bool:
	return !equal(to)

# greater or equal
func greateq(thanto: Variant) -> bool:
	return greater(thanto) || equal(thanto)

# greater or equal
func lesseq(thanto: Variant) -> bool:
	return less(thanto) || equal(thanto)

#>---COMPARISON/INEQUALITY---<#
