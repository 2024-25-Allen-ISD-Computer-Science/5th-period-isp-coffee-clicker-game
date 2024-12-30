class_name Bean 
extends Node2D

# bean properties
@export var Name : String
@export var unlocked : bool
@export var unlock_value : int
@export var sell_value : int
@export var upgrade_value : int
@export var upgrade_cost : int
@export var upgrade_cost_scale : int
@export var level : int

func _init(Name : String, unlocked : bool, unlock_value : int, sell_value : int, upgrade_value : int, upgrade_cost : int, upgrade_cost_scale : int, level : int = 1):
	self.Name = Name
	self.unlocked = unlocked
	self.unlock_value = unlock_value
	self.sell_value = sell_value
	self.upgrade_value = upgrade_value
	self.upgrade_cost = upgrade_cost
	self.upgrade_cost_scale = upgrade_cost_scale
	self.level = level

func upgrade_bean() -> void:
	sell_value += upgrade_value
	upgrade_cost += upgrade_cost_scale
	level += 1
	if (level % 10 == 0):
		sell_value *= 2
		upgrade_cost *= 2
		upgrade_value *= 2
		upgrade_cost_scale *= 4
