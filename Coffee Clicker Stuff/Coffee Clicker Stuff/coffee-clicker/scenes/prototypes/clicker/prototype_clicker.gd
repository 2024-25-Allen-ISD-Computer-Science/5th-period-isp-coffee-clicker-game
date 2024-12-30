class_name PrototypeClicker
extends Control


@export var label : Label

var money : int = 0

static var coffeeValue : int = 1

var upgradeCost : int = 5

@onready var upgrade : Button = get_node("Upgrade")

func _ready() -> void:
	upgrade.text = "Upgrade : %s" %upgradeCost
	
func _on_button_pressed() -> void:
	make_coffee()


func make_coffee() -> void:
	money += coffeeValue
	update_label_text()


func update_label_text() -> void:
	label.text = "Money : %s" %money


func update_upgrade() -> void:
	upgradeCost *= 1.5
	upgrade.text = "Upgrade : %s" %upgradeCost


func upgrade_coffee() -> void:
	coffeeValue += 1
	money -= upgradeCost
	update_upgrade()
	update_label_text()


func _on_upgrade_pressed() -> void:
	if (money >= upgradeCost):
		upgrade_coffee()
