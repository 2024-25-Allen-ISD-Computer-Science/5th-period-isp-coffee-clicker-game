class_name Bean 
extends Node2D

# bean properties
@export var bean_name : String
@export var sell_value : int
@export var upgrade_value : int
@export var upgrade_cost : int
@export var upgrade_cost_scale : int
@export var level : int

func _init(bean : String, value : int, upval : int, upcost : int, upcostscale : int, lvl : int):
	bean_name = bean
	sell_value = value
	upgrade_value = upval
	upgrade_cost = upcost
	upgrade_cost_scale = upcostscale
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
