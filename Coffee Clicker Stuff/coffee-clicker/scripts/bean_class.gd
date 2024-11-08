class_name Bean 
extends Node2D

# bean properties
@export var Name : String
@export var sell_value : int
@export var upgrade_value : int
@export var upgrade_cost : int
@export var upgrade_cost_scale : int
@export var level : int

func _init(bean_name : String, bean_value : int, bean_upgrade_value : int, bean_upgrade_cost : int, bean_upgrade_cost_scale : int, lvl : int):
	Name = bean_name
	sell_value = bean_value
	upgrade_value = bean_upgrade_value
	upgrade_cost = bean_upgrade_cost
	upgrade_cost_scale = bean_upgrade_cost_scale
	level = lvl

func upgrade_bean():
	sell_value += upgrade_value
	upgrade_cost += upgrade_cost_scale
	level += 1
	if (level % 10 == 0):
		sell_value *= 2
		upgrade_cost *= 2
		upgrade_value *= 2
		upgrade_cost_scale *= 4
