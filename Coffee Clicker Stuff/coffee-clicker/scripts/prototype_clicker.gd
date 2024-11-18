class_name PrototypeClicker
extends Control

# variable setup
@export var label : Label
var money : int = 0
static var coffeeValue : int = 1
var unlock_cooldown : int = 0
var beandex : int = 1 # we begin w/ excelsa, so it's not counted in the unlock progression
@onready var unlock : Button = get_node("Unlock")

#>---BEAN VARS---<#
var beans : Array
var excelsa
var robusta
#>---BEAN VARS---<#

#>---UPGRADE VARS---<#
var upgrades : Array
@onready var upgrade_excelsa : Button = get_node("Upgrade_Excelsa")
@onready var upgrade_robusta : Button = get_node("Upgrade_Robusta")
#>---UPGRADE VARS---<#

#>---ICON VARS---<#
var icons : Array
@onready var excelsa_icon : Sprite2D = get_node("Excelsa_Icon")
@onready var robusta_icon : Sprite2D = get_node("Robusta_Icon")
#>---ICON VARS---<#



# calls on startup
func _ready() -> void:
	excelsa = Bean.new("Excelsa", true, 0, 1, 1, 50, 25, 1)
	robusta = Bean.new("Robusta", false, 500, 5, 5, 200, 100, 1)
	beans = [excelsa, robusta]
	icons = [excelsa_icon, robusta_icon]
	upgrades = [upgrade_excelsa, upgrade_robusta]

# frame by frame processing
func _process(delta) -> void:
	update_coffee_value()
	update_money_text()
	update_unlock_text()
	update_upgrade_text()

#>---INTERACTION FUNCTIONS---<#
# function for when the make coffee button is pressed
func _on_button_pressed() -> void:
	make_coffee()
	$Coffee_Pot/AnimationPlayer.play("coffee_pot_click")
func _on_upgrade_excelsa_pressed() -> void:
	upgrade_bean(excelsa)
func _on_upgrade_robusta_pressed() -> void:
	upgrade_bean(robusta)
# unlocks beans
func _on_unlock_pressed() -> void:
	if unlock_cooldown == 0 && beandex < beans.size():
		if (money >= beans[beandex].unlock_value):
			beans[beandex].unlocked = true
			money -= beans[beandex].unlock_value
			beandex += 1
			unlock_cooldown = 60
#>---INTERACTION FUNCTIONS---<#

#>---MONEY FUNCTIONS---<#
# upgrades excelsa bean sell_value if you have enough money
func upgrade_bean(bean) -> void:
	if bean.unlocked && money >= bean.upgrade_cost:
		money -= bean.upgrade_cost
		bean.upgrade_bean()
# updates your money
func make_coffee() -> void:
	money += coffeeValue
#>---MONEY FUNCTIONS---<#

#>---UPDATE FUNCTIONS---<#
# updates the value of your coffee
func update_coffee_value() -> void:
	coffeeValue = 0
	for bean in beans:
		if bean.unlocked:
			coffeeValue += bean.sell_value
# updates the amount of money displayed
func update_money_text() -> void:
	label.text = "Money: $%s" %money
# updates unlock text
func update_unlock_text() -> void:
	if unlock_cooldown != 0:
		unlock.text = ("%s Bean Unlocked" %beans[beandex-1].Name)
		unlock_cooldown -= 1
	elif beandex >= beans.size():
		unlock.text = "All beans unlocked!"
	else:
		unlock.text = ("Unlock %s Bean\n$%s" %[beans[beandex].Name, beans[beandex].unlock_value])
# updates the upgrade cost displayed
func update_upgrade_text() -> void:
	for index in beandex:
		upgrades[index].text = "%s\nCurrent Value: $%s\nUpgrade: $%s\nLevel: %s" %[beans[index].Name, beans[index].sell_value, beans[index].upgrade_cost, beans[index].level]
#>---UPDATE FUNCTIONS---<#



# Next ideas:
	# The upgrade buttons are all identical, aside from their position and the bean they relate to
	# We could make a class for upgrade buttons, that each have a specific ID number, like with the beans
	# From there upgrading beans could be made more versatile, as
		# A function in prototype_clicker that utilizes the ID of the button
		# A function in the upgrade button class that goes directly to their corresponding bean
