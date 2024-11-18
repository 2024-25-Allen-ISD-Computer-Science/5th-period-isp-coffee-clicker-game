extends Control


# variable setup
@export var label : Label
var money : int = 100000
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
	arabica = Bean.new("Arabica", false, 2000, 10, 10, 500, 250)
	liberica = Bean.new("Liberica", false, 10000, 25, 25, 2500, 1250)
	beans = [excelsa, robusta, arabica, liberica]
	upgrade_icons = [excelsa_upgrade_icon, robusta_upgrade_icon, arabica_upgrade_icon, liberica_upgrade_icon]
	upgrade_sprites = [excelsa_upgrade_sprite, robusta_upgrade_sprite, arabica_upgrade_sprite, liberica_upgrade_sprite]
	upgrades = [upgrade_excelsa, upgrade_robusta, upgrade_arabica, upgrade_liberica]


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
# updates the value of your coffee
func update_text() -> void:
	update_coffee_value()
	update_money_text()
	update_unlock_text()
	update_upgrade_text()
	
func update_coffee_value() -> void:
	coffeeValue = 0
	for bean in beans:
		if bean.unlocked:
			coffeeValue += bean.sell_value


# updates the amount of money displayed
func update_money_text() -> void:
	label.text = "$%s" %money


# updates unlock text
func update_unlock_text() -> void:
	if beandex >= beans.size():
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
