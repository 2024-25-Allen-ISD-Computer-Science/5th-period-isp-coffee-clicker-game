class_name PrototypeClicker
extends Control

# variable setup
@export var label : Label
var money : int = 100000
static var coffeeValue : int = 1
var beans : Array
var bean_icons : Array
var bean_upgrades : Array
var beandex : int = 1 # we begin w/ excelsa, so it's not counted in the unlock progression
@onready var upgrade_excelsa : Button = get_node("Upgrade_Excelsa")
@onready var upgrade_robusta : Button = get_node("Upgrade_Robusta")
@onready var unlock : Button = get_node("Unlock")
@onready var excelsa_icon : Sprite2D = get_node("Excelsa_Icon")
@onready var robusta_icon : Sprite2D = get_node("Robusta_Icon")
var excelsa
var robusta

# calls on startup
func _ready() -> void:
	excelsa = Bean.new("Excelsa", true, 0, 1, 1, 50, 25, 1)
	robusta = Bean.new("Robusta", false, 500, 5, 5, 200, 100, 1)
	beans = [excelsa, robusta]
	bean_icons = [excelsa_icon, robusta_icon]
	bean_upgrades = [upgrade_excelsa, upgrade_robusta]

# frame by frame processing
func _process(delta) -> void:
	update_coffee_value()
	update_money_text()
	update_unlock_text()
	for index in beans.size():
		update_upgrade_text(bean_upgrades[index], beans[index])

# function for when the make coffee button is pressed
func _on_button_pressed() -> void:
	make_coffee()
	$Coffee_Pot/AnimationPlayer.play("coffee_pot_click")

# UPDATE FUNCTIONS

# updates your money
func make_coffee() -> void:
	money += coffeeValue
# updates the amount of money displayed
func update_money_text() -> void:
	label.text = "Money : $ %s" %money
# updates the upgrade cost displayed
func update_upgrade_text(upgrade, bean) -> void:
	if bean.unlocked:
		upgrade.text = (bean.Name) + ("\nCurrent Value: $ %s" %bean.sell_value) + ("\nUpgrade : $ %s" %bean.upgrade_cost) + ("\nLevel : %s" %bean.level)
# updates the value of your coffee
func update_coffee_value() -> void:
	coffeeValue = 0
	for bean in beans:
		if bean.unlocked:
			coffeeValue += bean.sell_value
# updates unlock text
func update_unlock_text() -> void:
	if beandex >= beans.size():
		unlock.text = "All beans unlocked!"
	else:
		unlock.text = ("Unlock %s Bean\n$%s" %[beans[beandex].Name, beans[beandex].unlock_value])

# unlocks beans
func _on_unlock_pressed() -> void:
	if beandex < beans.size():
		if (money >= beans[beandex].unlock_value):
			beans[beandex].unlocked = true
			money -= beans[beandex].unlock_value
			beandex += 1

# UPGRADE FUNCTIONS

# upgrades excelsa bean sell_value if you have enough money
func upgrade_bean(upgrade, bean) -> void:
	if bean.unlocked && money >= bean.upgrade_cost:
		money -= bean.upgrade_cost
		bean.upgrade_bean()
		
func _on_upgrade_excelsa_pressed() -> void:
	upgrade_bean(upgrade_excelsa, excelsa)
func _on_upgrade_robusta_pressed() -> void:
	upgrade_bean(upgrade_robusta, robusta)
