class_name PrototypeClicker
extends Control


# variable setup
@export var label : Label

var money : int = 0

static var coffeeValue : int = 1

var level : int = 0

var beans : Array = []

@onready var upgrade_excelsa : Button = get_node("Upgrade_Excelsa")

var excelsa

# calls on startup
func _ready() -> void:
	excelsa = Bean.new("Excelsa Bean", 1, 1, 50, 50, 1)
	beans.append(excelsa)
	update_money_text()
	update_upgrade_text(excelsa)


# function for when the make coffee button is pressed
func _on_button_pressed() -> void:
	make_coffee()
	$Coffee_Pot/AnimationPlayer.play("coffee_pot_click")


# updates your money
func make_coffee() -> void:
	money += coffeeValue
	update_money_text()


# updates the amount of money displayed
func update_money_text() -> void:
	label.text = "Money : $ %s" %money


# updates the upgrade cost displayed
func update_upgrade_text(bean) -> void:
	upgrade_excelsa.text = ("Upgrade : $ %s" %bean.upgrade_cost) + ("\nLevel : %s" %bean.level)


# updates the value of your coffee
func update_coffee_value() -> void:
	coffeeValue = 0
	for coffee_bean in beans:
		coffeeValue += coffee_bean.sell_value
	update_upgrade_text(excelsa)
	update_money_text()


# upgrades excelsa bean sell_value if you have enough money
func _on_upgrade_excelsa_pressed() -> void:
	if (money >= excelsa.upgrade_cost):
		money -= excelsa.upgrade_cost
		excelsa.upgrade_bean()
		update_coffee_value()
