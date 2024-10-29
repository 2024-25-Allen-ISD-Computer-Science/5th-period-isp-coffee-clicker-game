class_name PrototypeClicker
extends Control


# variable setup
@export var label : Label

var money : int = 0

static var coffeeValue : int = 1

var upgradeCost : int = 50

var upgradeAmount : int = 1

var upgradeCostScale : int = 25

var level : int = 0

@onready var upgrade : Button = get_node("Upgrade")


# calls on startup
func _ready() -> void:
	update_label_text()
	update_upgrade_text()

# makes upgrade cost increase more on upgrade
# makes upgrade amount increase more on upgrade
func scale_upgrade() -> void:
	upgradeCostScale *= 4
	upgradeAmount *= 2


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
	upgrade.text = ("Upgrade : $ %s" %upgradeCost) + ("\nLevel : %s" %level)


# makes your coffee worth more money and upgrades cost more
func upgrade_coffee() -> void:
	level += 1
	coffeeValue += upgradeAmount
	money -= upgradeCost
	upgradeCost += upgradeCostScale
	update_upgrade_text()
	update_label_text()
	if level % 10 == 0:
		scale_upgrade()


# upgrades coffee if you have enough money
func _on_upgrade_pressed() -> void:
	if (money >= upgradeCost):
		upgrade_coffee()
