class_name PrototypeClicker
extends Control


# variable setup
@export var label : Label


var money : int = 0


static var coffeeValue : int = 1


var beans : Array = []


@onready var upgrade_excelsa : Button = get_node("Upgrade_Excelsa")

@onready var upgrade_robusta : Button = get_node("Upgrade_Robusta")


@onready var unlock_robusta : Button = get_node("Unlock_Robusta")


@onready var robusta_unlocked : bool = false

var excelsa

var robusta


var robusta_unlock_cost = 500

# calls on startup
func _ready() -> void:
	excelsa = Bean.new("Excelsa Bean", 1, 1, 50, 25, 1)
	beans.append(excelsa)
	update_money_text()
	update_upgrade_text(upgrade_excelsa, excelsa)


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
func update_upgrade_text(upgrade, bean) -> void:
	upgrade.text = (bean.Name) + ("\nCurrent Value: $ %s" %bean.sell_value) + ("\nUpgrade : $ %s" %bean.upgrade_cost) + ("\nLevel : %s" %bean.level)


# updates the value of your coffee
func update_coffee_value() -> void:
	coffeeValue = 0
	for coffee_bean in beans:
		coffeeValue += coffee_bean.sell_value
	update_money_text()


# bean unlock functions
# unlocks robusta bean
func _on_unlock_robusta_pressed() -> void:
		if ((money >= robusta_unlock_cost) && (robusta_unlocked == false)):
			robusta_unlocked = true
			robusta = Bean.new("Robusta Bean", 5, 5, 200, 100, 1)
			beans.append(robusta)
			money -= robusta_unlock_cost
			update_coffee_value()
			update_upgrade_text(upgrade_robusta, robusta)
			unlock_robusta.text = "Robusta Unlocked"


# upgrade functions
# upgrades excelsa bean sell_value if you have enough money
func upgrade_bean(upgrade, bean) -> void:
	if (money >= bean.upgrade_cost):
		money -= bean.upgrade_cost
		bean.upgrade_bean()
		update_coffee_value()
		update_upgrade_text(upgrade, bean)

func _on_upgrade_excelsa_pressed() -> void:
	upgrade_bean(upgrade_excelsa, excelsa)


func _on_upgrade_robusta_pressed() -> void:
	if robusta_unlocked:
		upgrade_bean(upgrade_robusta, robusta)
