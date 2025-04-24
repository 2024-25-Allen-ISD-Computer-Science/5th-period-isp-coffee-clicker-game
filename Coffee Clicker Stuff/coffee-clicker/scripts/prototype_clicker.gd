extends Control


# variable setup
@export var label : Label
var money : Massint = Massint.new([0])
static var coffeeValue : Massint = Massint.new([1])
var beandex : int = 1 # we begin w/ excelsa, so it's not counted in the unlock progression
@onready var unlock : TextureButton = get_node("Unlock_Bean2")
@onready var unlock_text : RichTextLabel = get_node("Unlock_Bean2/Unlock_Bean_Label")
var map = Map.new(grid)
@onready var cursor_object : TextureRect 

#>---BUILDING VARS---<#
@onready var espresso_hut : Building = Building.new(2, 0, 2.0, 0.0, espresso_hut_sprite)
@onready var bag_house : Building = Building.new(2, 0, 10.0, 0.0, bag_house_sprite)
@onready var vending_apartment : Building = Building.new(2, 0, 50.0, 0.0, vending_apartment_sprite)
@onready var sugar_towers : Building = Building.new(2, 0, 300.0, 0.0, sugar_towers_sprite)
#>---BUILDING VARS---<#

#>---BUILDING SPRITE TEXTURE VARS---<#
@onready var espresso_hut_sprite : Texture2D = preload("res://Assets/Houses/pineapple.png")
@onready var bag_house_sprite : Texture2D = preload("res://Assets/Houses/middle house.png")
@onready var vending_apartment_sprite : Texture2D = preload("res://Assets/Houses/vending appartmnents.png")
@onready var sugar_towers_sprite : Texture2D = preload("res://Assets/Houses/twin towers.png")
#>---BUILDING SPRITE TEXTURE VARS---<#

#>---GRID VAR---<#
var grid = [[grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock)],
			[grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock)],
			[grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(1), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock)],
			[grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock)],
			[grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock), grid_block.new(Building.new(0), $Building_Menu/Building_Grid/Building_GridBlock)]] 
#>---GRID VAR---<#

#>---BEAN VARS---<#
var beans : Array
var excelsa
var robusta
var arabica
var liberica
var kidney
var evil
var toe
var magic
var rainbow
var holbean
#>---BEAN VARS---<#


#>---UPGRADE VARS---<#
var upgrades : Array
@onready var upgrade_excelsa : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Excelsa2")
@onready var upgrade_robusta : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Robusta2")
@onready var upgrade_arabica : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Arabica2")
@onready var upgrade_liberica : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Liberica2")
@onready var upgrade_kidney : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Kidney")
@onready var upgrade_evil : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Evil")
@onready var upgrade_toe : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Toe")
@onready var upgrade_magic : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Magic")
@onready var upgrade_rainbow : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Rainbow")
@onready var upgrade_holbean : TextureButton = get_node("ScrollContainer/VBoxContainer/Upgrade_Holbean")
#>---UPGRADE VARS---<#


#>---UPGRADE ICON VARS---<#
var upgrade_icons : Array
@onready var excelsa_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Excelsa2/Excelsa_Upgrade_Icon")
@onready var robusta_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Robusta2/Robusta_Upgrade_Icon")
@onready var arabica_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Arabica2/Arabica_Upgrade_Icon")
@onready var liberica_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Liberica2/Liberica_Upgrade_Icon")
@onready var kidney_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Kidney/Kidney_Upgrade_Icon")
@onready var evil_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Evil/Evil_Upgrade_Icon")
@onready var toe_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Toe/Toe_Upgrade_Icon")
@onready var magic_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Magic/Magic_Upgrade_Icon")
@onready var rainbow_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Rainbow/Rainbow_Upgrade_Icon")
@onready var holbean_upgrade_icon : Sprite2D = get_node("ScrollContainer/VBoxContainer/Upgrade_Holbean/Holbean_Upgrade_Icon")
#>---UPGRADE ICON VARS---<#


#>---UPGRADE ICON SPRITES---<#
var upgrade_sprites : Array
@onready var excelsa_upgrade_sprite : Texture2D = preload("res://Assets/Beans/excelsa bean.png")
@onready var robusta_upgrade_sprite : Texture2D = preload("res://Assets/Beans/robusta bean.png")
@onready var arabica_upgrade_sprite : Texture2D = preload("res://Assets/Beans/arabaca bean.png")
@onready var liberica_upgrade_sprite : Texture2D = preload("res://Assets/Beans/liberica bean.png")
@onready var kidney_upgrade_sprite : Texture2D = preload("res://Assets/Beans/kidny bean.png")
@onready var evil_upgrade_sprite : Texture2D = preload("res://Assets/Beans/evil_bean.png")
@onready var toe_upgrade_sprite : Texture2D = preload("res://Assets/Beans/toe beans.png")
@onready var magic_upgrade_sprite : Texture2D = preload("res://Assets/Beans/magic_bean.png")
@onready var rainbow_upgrade_sprite : Texture2D = preload("res://Assets/Beans/rainbow bean.png")
@onready var holbean_upgrade_sprite : Texture2D = preload("res://Assets/Beans/Mr.Hole Bean.png")
#>---UPGRADE ICON SPRITES---<#


#>---UPGRADE LABELS---<#
var upgrade_labels : Array
@onready var excelsa_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Excelsa2/Excelsa_Label")
@onready var robusta_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Robusta2/Robusta_Label")
@onready var arabica_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Arabica2/Arabica_Label")
@onready var liberica_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Liberica2/Liberica_Label")
@onready var kidney_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Kidney/Kidney_Label")
@onready var evil_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Evil/Evil_Label")
@onready var toe_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Toe/Toe_Label")
@onready var magic_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Magic/Magic_Label")
@onready var rainbow_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Rainbow/Rainbow_Label")
@onready var holbean_label : RichTextLabel = get_node("ScrollContainer/VBoxContainer/Upgrade_Holbean/Holbean_Label")
#>---UPGRADE LABELS---<#

#>---BUILDING SHOP BUTTONS---<#
var building_shop_buttons : Array
@onready var building_one_button : TextureButton = get_node("Building_Menu/Building_Shop_Menu/ScrollContainer/VBoxContainer/Buy_Building_One")
#>---BUILDING SHOP BUTTONS---<#
func test():
	pass

# calls on startup
# sets up all the beans
func _ready() -> void:
	test()
	$Background.frame = 30
	$Background.play("background_anim")
	excelsa = Bean.new("Excelsa", true, 0, 1, 1, 50, 25)
	robusta = Bean.new("Robusta", false, 500, 5, 5, 200, 100)
	arabica = Bean.new("Arabica", false, 10000, 10, 10, 500, 250)
	liberica = Bean.new("Liberica", false, 250000, 50, 50, 2500, 1250)
	kidney = Bean.new("Kidney Bean", false, 10000000, 500, 500, 500000, 250000) #10 million UV
	evil = Bean.new("Evil Bean", false, 250000000, 10000, 10000, 5000000, 2500000) #250 million UV
	toe = Bean.new("Toe Bean", false, 50000000000, 1000000, 1000000, 250000000, 125000000) #50 billion UV
	magic = Bean.new("Magic Bean", false, 2000000000000, 20000000, 20000000, 250000000, 125000000) #2 trillion UV
	rainbow = Bean.new("Rainbow Bean", false, 100000000000000, 750000000, 750000000, 10000000000, 5000000000) #100 trillion UV
	holbean = Bean.new("Holbean", false, 50000000000000000, 150000000000, 150000000000, 2000000000000, 1000000000000) #50 quadrillion UV
	beans = [excelsa, robusta, arabica, liberica, kidney, evil, toe, magic, rainbow, holbean]
	upgrade_icons = [excelsa_upgrade_icon, robusta_upgrade_icon, arabica_upgrade_icon, liberica_upgrade_icon, kidney_upgrade_icon, evil_upgrade_icon, toe_upgrade_icon, magic_upgrade_icon, rainbow_upgrade_icon, holbean_upgrade_icon]
	upgrade_sprites = [excelsa_upgrade_sprite, robusta_upgrade_sprite, arabica_upgrade_sprite, liberica_upgrade_sprite, kidney_upgrade_sprite, evil_upgrade_sprite, toe_upgrade_sprite, magic_upgrade_sprite, rainbow_upgrade_sprite, holbean_upgrade_sprite]
	upgrade_labels = [excelsa_label, robusta_label, arabica_label, liberica_label, kidney_label, evil_label, toe_label, magic_label, rainbow_label, holbean_label]
	upgrades = [upgrade_excelsa, upgrade_robusta, upgrade_arabica, upgrade_liberica, upgrade_kidney, upgrade_evil, upgrade_toe, upgrade_magic, upgrade_rainbow, upgrade_holbean]
	update_text()

func _process(delta) -> void:
	pass


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

func _on_upgrade_kidney_pressed() -> void:
	upgrade_bean(kidney)
	update_text()

func _on_upgrade_evil_pressed() -> void:
	upgrade_bean(evil)
	update_text()

func _on_upgrade_toe_pressed() -> void:
	upgrade_bean(toe)
	update_text()

func _on_upgrade_magic_pressed() -> void:
	upgrade_bean(magic)
	update_text()

func _on_upgrade_rainbow_pressed() -> void:
	upgrade_bean(rainbow)
	update_text()

func _on_upgrade_holbean_pressed() -> void:
	upgrade_bean(holbean)
	update_text()

func _on_building_one_button_pressed() -> void:
	print("penis")


# unlocks beans
func _on_unlock_pressed() -> void:
	if beandex < beans.size():
		if (money.greateq(beans[beandex].unlock_value)):
			beans[beandex].unlocked = true
			upgrade_icons[beandex].texture = upgrade_sprites[beandex]
			money = money.subtract(beans[beandex].unlock_value)
			beandex += 1
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
	money = money.add(coffeeValue * map.multipliers)
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
