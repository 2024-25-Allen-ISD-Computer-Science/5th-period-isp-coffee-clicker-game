class_name PrototypeClicker
extends Control


# variable setup
@export var label : Label

var money : int = 0

static var coffeeValue : int = 1

var upgradeCost : int = 50

@onready var upgrade : Button = get_node("Upgrade")


# calls on startup
func _ready() -> void:
	update_label_text()
	update_upgrade_text()


# function for when the make coffee button is pressed
func _on_button_pressed() -> void:
	make_coffee()


# updates your money
func make_coffee() -> void:
	money += coffeeValue
	update_label_text()


# updates the amount of money displayed
func update_label_text() -> void:
	label.text = "Money : $ %s" %money


# updates the upgrade cost displayed
func update_upgrade_text() -> void:
	upgrade.text = "Upgrade : $ %s" %upgradeCost


# makes your coffee worth more money and upgrades cost more
func upgrade_coffee() -> void:
	coffeeValue += 1
	money -= upgradeCost
	upgradeCost *= 1.25
	update_upgrade_text()
	update_label_text()


# upgrades coffee if you have enough money
func _on_upgrade_pressed() -> void:
	if (money >= upgradeCost):
		upgrade_coffee()
