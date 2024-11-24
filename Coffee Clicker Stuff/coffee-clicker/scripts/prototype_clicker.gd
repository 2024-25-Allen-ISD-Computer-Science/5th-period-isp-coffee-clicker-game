extends Control


# variable setup
@export var label : Label
var money : int = 8457934758
static var coffeeValue : int = 1
var unlock_cooldown : int = 0
var beandex : int = 1 # we begin w/ excelsa, so it's not counted in the unlock progression
@onready var unlock : Button = get_node("Unlock_Bean")


#>---BEAN VARS---<#
var beans : Array
var excelsa
var robusta
var arabica
var liberica
#>---BEAN VARS---<#


#>---UPGRADE VARS---<#
var upgrades : Array
@onready var upgrade_excelsa : Button = get_node("ScrollContainer/VBoxContainer/Upgrade_Excelsa")
@onready var upgrade_robusta : Button = get_node("ScrollContainer/VBoxContainer/Upgrade_Robusta")
@onready var upgrade_arabica : Button = get_node("ScrollContainer/VBoxContainer/Upgrade_Arabica")
@onready var upgrade_liberica : Button = get_node("ScrollContainer/VBoxContainer/Upgrade_Liberica")
#>---UPGRADE VARS---<#


#>---UPGRADE ICON VARS---<#
var upgrade_icons : Array
@onready var excelsa_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Excelsa/Excelsa_Upgrade_Icon")
@onready var robusta_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Robusta/Robusta_Upgrade_Icon")
@onready var arabica_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Arabica/Arabica_Upgrade_Icon")
@onready var liberica_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Liberica/Liberica_Upgrade_Icon")
#>---UPGRADE ICON VARS---<#


#>---UPGRADE ICON SPRITES---<#
var upgrade_sprites : Array
@onready var excelsa_upgrade_sprite : Texture2D = preload("res://Assets/excelsa bean.png")
@onready var robusta_upgrade_sprite : Texture2D = preload("res://Assets/robusta bean.png")
@onready var arabica_upgrade_sprite : Texture2D = preload("res://Assets/arabaca bean.png")
@onready var liberica_upgrade_sprite : Texture2D = preload("res://Assets/liberica bean.png")
#>---UPGRADE ICON SPRITES---<#


# calls on startup
# sets up all the beans
func _ready() -> void:
	excelsa = Bean.new("Excelsa", true, 0, 1, 1, 50, 25)
	robusta = Bean.new("Robusta", false, 500, 5, 5, 200, 100)
	arabica = Bean.new("Arabica", false, 10000, 10, 10, 500, 250)
	liberica = Bean.new("Liberica", false, 250000, 50, 50, 2500, 1250)
	beans = [excelsa, robusta, arabica, liberica]
	upgrade_icons = [excelsa_upgrade_icon, robusta_upgrade_icon, arabica_upgrade_icon, liberica_upgrade_icon]
	upgrade_sprites = [excelsa_upgrade_sprite, robusta_upgrade_sprite, arabica_upgrade_sprite, liberica_upgrade_sprite]
	upgrades = [upgrade_excelsa, upgrade_robusta, upgrade_arabica, upgrade_liberica]
	update_text()


# frame by frame processing
#func _process(delta) -> void:
#	update_coffee_value()
#	update_money_text()
#	update_unlock_text()
#	update_upgrade_text()


#>---INTERACTION FUNCTIONS---<#
# function for when the make coffee button is pressed
func _on_button_pressed() -> void:
	make_coffee()
	$Button/Coffee_Pot/AnimationPlayer.play("coffee_pot_click")
	update_money_text()


# functions for upgrading beans
func _on_upgrade_excelsa_pressed() -> void:
	upgrade_bean(excelsa)
	update_text()
	
func _on_upgrade_robusta_pressed() -> void:
	upgrade_bean(robusta)
	update_text()
	
func _on_upgrade_arabica_pressed() -> void:
	upgrade_bean(arabica)
	update_text()

func _on_upgrade_liberica_pressed() -> void:
	upgrade_bean(liberica)
	update_text()


# unlocks beans
func _on_unlock_pressed() -> void:
	if beandex < beans.size():
		if (money >= beans[beandex].unlock_value):
			beans[beandex].unlocked = true
			upgrade_icons[beandex].texture = upgrade_sprites[beandex]
			money -= beans[beandex].unlock_value
			beandex += 1
			update_text()
#>---INTERACTION FUNCTIONS---<#


#>---MONEY FUNCTIONS---<#
# upgrades bean sell_value if you have enough money
func upgrade_bean(bean) -> void:
	if bean.unlocked && money >= bean.upgrade_cost:
		money -= bean.upgrade_cost
		bean.upgrade_bean()


# updates your money
func make_coffee() -> void:
	money += coffeeValue
#>---MONEY FUNCTIONS---<#


#>---UPDATE FUNCTIONS---<#
func update_text() -> void:
	update_coffee_value()
	update_money_text()
	update_unlock_text()
	update_upgrade_text()
	
	
# updates the value of your coffee
func update_coffee_value() -> void:
	coffeeValue = 0
	for bean in beans:
		if bean.unlocked:
			coffeeValue += bean.sell_value


# updates the amount of money displayed
func update_money_text() -> void:
	var condense = condense_num(money)
	label.text = "$%s" %condense


# updates unlock text
func update_unlock_text() -> void:
	if beandex >= beans.size():
		unlock.text = "All beans unlocked!"
	else:
		var unlock_value = condense_num(beans[beandex].unlock_value)
		unlock.text = ("Unlock %s Bean\n$%s" %[beans[beandex].Name, unlock_value])


# updates the upgrade cost displayed
func update_upgrade_text() -> void:
	for index in beandex:
		var sell_value = condense_num(beans[index].sell_value)
		var upgrade_cost = condense_num(beans[index].upgrade_cost)
		upgrades[index].text = "%s\nCurrent Value: $%s\nUpgrade: $%s\nLevel: %s" %[beans[index].Name, sell_value, upgrade_cost, beans[index].level]
#>---UPDATE FUNCTIONS---<#


#>---MATHEMATICS FUNCTIONS---<#
# simplifies a number (if large enough) into its first 3 digits and a suffix
func condense_num(num: int) -> String:
	var suffixes = ["k", "m", "b"]
	var num_string = str(num)
	if num_string.length() >= 5:
		var threes = floor((num_string.length() - 1) / 3) # counts digits in threes (omitting the first)
		var condense = floor_to(float(num) / (10 ** (threes * 3)), 2) # divides number to ones place and floors to the hundredth
		if threes > suffixes.size():
			num_string = e_notation(condense, num_string.length())
		else:
			num_string = str(condense) + suffixes[threes - 1]
	return num_string


# floors value to a specific decimal
func floor_to(num: float, power: int = 0) -> float:
	var result = floor(num * (10 ** power)) / (10 ** power)
	return result


# failsafe; converts number into e notation if too large for a suffix
func e_notation(num: float, size: int) -> String:
	return str(num) + "e+" + str(size - 1)
#>---MATHEMATICS FUNCTIONS---<#
