extends Control


# variable setup
@export var label : Label
var money : Massint = Massint.new([0])
static var coffeeValue : Massint = Massint.new([1])
var beandex : int = 1 # we begin w/ excelsa, so it's not counted in the unlock progression
@onready var unlock : TextureButton = get_node("Unlock_Bean2")
@onready var unlock_text : RichTextLabel = get_node("Unlock_Bean2/Unlock_Bean_Label")
var map = Map.new()


#>---BEAN VARS---<#
var beans : Array
var excelsa
var robusta
var arabica
var liberica
#>---BEAN VARS---<#


#>---UPGRADE VARS---<#
var upgrades : Array
@onready var upgrade_excelsa : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Excelsa2")
@onready var upgrade_robusta : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Robusta2")
@onready var upgrade_arabica : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Arabica2")
@onready var upgrade_liberica : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Liberica2")
#>---UPGRADE VARS---<#


#>---UPGRADE ICON VARS---<#
var upgrade_icons : Array
@onready var excelsa_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Excelsa2/Excelsa_Upgrade_Icon")
@onready var robusta_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Robusta2/Robusta_Upgrade_Icon")
@onready var arabica_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Arabica2/Arabica_Upgrade_Icon")
@onready var liberica_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Liberica2/Liberica_Upgrade_Icon")
#>---UPGRADE ICON VARS---<#


#>---UPGRADE ICON SPRITES---<#
var upgrade_sprites : Array
@onready var excelsa_upgrade_sprite : Texture2D = preload("res://Assets/excelsa bean.png")
@onready var robusta_upgrade_sprite : Texture2D = preload("res://Assets/robusta bean.png")
@onready var arabica_upgrade_sprite : Texture2D = preload("res://Assets/arabaca bean.png")
@onready var liberica_upgrade_sprite : Texture2D = preload("res://Assets/liberica bean.png")
#>---UPGRADE ICON SPRITES---<#


#>---Upgrade Labels---<#
var upgrade_labels : Array
@onready var excelsa_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Excelsa2/Excelsa_Label")
@onready var robusta_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Robusta2/Robusta_Label")
@onready var arabica_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Arabica2/Arabica_Label")
@onready var liberica_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Liberica2/Liberica_Label")
#>---Upgrade Labels---<#

func test():
	pass

# calls on startup
# sets up all the beans
func _ready() -> void:
	test()
	excelsa = Bean.new("Excelsa", true, 0, 1, 1, 50, 25)
	robusta = Bean.new("Robusta", false, 500, 5, 5, 200, 100)
	arabica = Bean.new("Arabica", false, 10000, 10, 10, 500, 250)
	liberica = Bean.new("Liberica", false, 250000, 50, 50, 2500, 1250)
	beans = [excelsa, robusta, arabica, liberica]
	upgrade_icons = [excelsa_upgrade_icon, robusta_upgrade_icon, arabica_upgrade_icon, liberica_upgrade_icon]
	upgrade_sprites = [excelsa_upgrade_sprite, robusta_upgrade_sprite, arabica_upgrade_sprite, liberica_upgrade_sprite]
	upgrade_labels = [excelsa_label, robusta_label, arabica_label, liberica_label]
	upgrades = [upgrade_excelsa, upgrade_robusta, upgrade_arabica, upgrade_liberica]
	update_text()

# frame by frame processing
#func _process(delta) -> void:
#	update_coffee_value()
#	update_money_text()
#	update_unlock_text()
#	update_upgrade_text()


#>---INTERACTION FUNCTIONS---<#
# function for when you click the upgrade menu button, opens up the menu and makes other things invisible
func _on_upgrade_menu_pressed() -> void:
	get_node("Unlock_Bean2").show()
	get_node("Upgrade_Menu_Background").show()
	get_node("ScrollContainer").show()
	get_node("Close_Upgrade_Menu").show()
	get_node("Building_Menu_Button").hide()

#function for when you click the close upgrade menu button, closes up the menu and makes other things visible
func _on_close_upgrade_menu_pressed() -> void:
	get_node("Unlock_Bean2").hide()
	get_node("Upgrade_Menu_Background").hide()
	get_node("ScrollContainer").hide()
	get_node("Close_Upgrade_Menu").hide()
	get_node("Building_Menu_Button").show()

func _on_building_menu_button_pressed() -> void:
	get_node("Building_Menu").show()
	get_node("Building_Menu_Button").hide()
	get_node("Upgrade_Menu_Button").hide()

func _on_close_building_menu_pressed() -> void:
	get_node("Building_Menu").hide()
	get_node("Building_Menu_Button").show()
	get_node("Upgrade_Menu_Button").show()
	
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
		if (money.greateq(beans[beandex].unlock_value)):
			beans[beandex].unlocked = true
			upgrade_icons[beandex].texture = upgrade_sprites[beandex]
			money = money.subtract(beans[beandex].unlock_value)
			beandex += 1
			map.multipliers.append(1)
			update_text()
#>---INTERACTION FUNCTIONS---<#


#>---MONEY FUNCTIONS---<#
# upgrades bean sell_value if you have enough money
func upgrade_bean(bean) -> void:
	if bean.unlocked && money.greateq(bean.upgrade_cost):
		money = money.subtract(bean.upgrade_cost)
		bean.upgrade_bean()


# updates your money
func make_coffee() -> void:
	money = money.add(coffeeValue)
#>---MONEY FUNCTIONS---<#


#>---UPDATE FUNCTIONS---<#
func update_text() -> void:
	update_coffee_value()
	update_money_text()
	update_unlock_text()
	update_upgrade_text()
	
	
# updates the value of your coffee
func update_coffee_value() -> void:
	coffeeValue.value = [0]
	for index in range(beandex):
		coffeeValue = coffeeValue.add(beans[index].sell_value)


# updates the amount of money displayed
func update_money_text() -> void:
	label.text = "$%s" % money.condensed()


# updates unlock text
func update_unlock_text() -> void:
	if beandex >= beans.size():
		unlock_text.text = "[center]All beans unlocked![/center]"
	else:
		var unlock_value = beans[beandex].unlock_value.condensed()
		unlock_text.text = ("[center]Unlock %s Bean\n$%s[/center]" %[beans[beandex].Name, unlock_value])


# updates the upgrade cost displayed
func update_upgrade_text() -> void:
	for index in beandex:
		var sell_value = beans[index].sell_value.condensed()
		var upgrade_cost = beans[index].upgrade_cost.condensed()
		upgrade_labels[index].text = "%s\nCurrent Value: $%s\nUpgrade: $%s\nLevel: %s" %[beans[index].Name, sell_value, upgrade_cost, beans[index].level]
#>---UPDATE FUNCTIONS---<#
