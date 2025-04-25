extends Control


# variable setup
@export var label : Label
var money : Massint = Massint.new([0,0,0,0,0,100])
static var coffeeValue : Massint = Massint.new([1])
var beandex : int = 1 # we begin w/ excelsa, so it's not counted in the unlock progression
@onready var unlock : TextureButton = get_node("Unlock_Bean2")
@onready var unlock_text : RichTextLabel = get_node("Unlock_Bean2/Unlock_Bean_Label")
@onready var cursor_object : TextureRect = $Building_Menu/Cursor_Object
var swap_queue = []

#>---BUILDING SPRITE TEXTURE VARS---<#
@onready var stand_sprite : Texture2D = preload("res://Assets/CoffeeBean.png")
@onready var espresso_hut_sprite : Texture2D = preload("res://Assets/Houses/pineapple.png")
@onready var bag_house_sprite : Texture2D = preload("res://Assets/Houses/middle_house.png")
@onready var vending_apartment_sprite : Texture2D = preload("res://Assets/Houses/vending appartmnents.png")
@onready var sugar_towers_sprite : Texture2D = preload("res://Assets/Houses/twin_towers.png")
#>---BUILDING SPRITE TEXTURE VARS---<#

#>---BUILDING VARS---<#
@onready var espresso_hut
@onready var bag_house
@onready var vending_apartment
@onready var sugar_towers
#>---BUILDING VARS---<#

#>---GRID VAR---<#
@onready var grid = [[grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock1), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock2), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock3), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock4), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock5)],
			[grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock6), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock7), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock8), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock9), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock10)],
			[grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock11), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock12), grid_block.new(Building.new(1), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock13), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock14), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock15)],
			[grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock16), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock17), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock18), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock19), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock20)],
			[grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock21), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock22), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock23), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock24), grid_block.new(Building.new(0), $Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock25)]] 
@onready var map = Map.new(grid)
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
@onready var building_two_button : TextureButton = get_node("Building_Menu/Building_Shop_Menu/ScrollContainer/VBoxContainer/Buy_Building_Two")
@onready var building_three_button : TextureButton = get_node("Building_Menu/Building_Shop_Menu/ScrollContainer/VBoxContainer/Buy_Building_Three")
@onready var building_four_button : TextureButton = get_node("Building_Menu/Building_Shop_Menu/ScrollContainer/VBoxContainer/Buy_Building_Four")
#>---BUILDING SHOP BUTTONS---<#

#>---BUILDING GRID BUTTONS---<#
var buildings : Array
@onready var building1: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock1/Building")
@onready var building2: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock2/Building")
@onready var building3: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock3/Building")
@onready var building4: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock4/Building")
@onready var building5: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock5/Building")
@onready var building6: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock6/Building")
@onready var building7: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock7/Building")
@onready var building8: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock8/Building")
@onready var building9: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock9/Building")
@onready var building10: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock10/Building")
@onready var building11: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock11/Building")
@onready var building12: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock12/Building")
@onready var building13: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock13/Building")
@onready var building14: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock14/Building")
@onready var building15: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock15/Building")
@onready var building16: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock16/Building")
@onready var building17: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock17/Building")
@onready var building18: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock18/Building")
@onready var building19: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock19/Building")
@onready var building20: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock20/Building")
@onready var building21: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock21/Building")
@onready var building22: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock22/Building")
@onready var building23: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock23/Building")
@onready var building24: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock24/Building")
@onready var building25: TextureRect = get_node("Building_Menu/Building_Grid_Menu/Building_Grid/Building_GridBlock25/Building")
#>---BUILDING GRID BUTTONS---<#
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
	kidney = Bean.new("Kidney", false, 10000000, 500, 500, 500000, 250000) #10 million UV
	evil = Bean.new("Evil", false, 250000000, 10000, 10000, 5000000, 2500000) #250 million UV
	toe = Bean.new("Toe", false, 50000000000, 1000000, 1000000, 250000000, 125000000) #50 billion UV
	magic = Bean.new("Magic", false, 2000000000000, 20000000, 20000000, 250000000, 125000000) #2 trillion UV
	rainbow = Bean.new("Rainbow", false, 100000000000000, 750000000, 750000000, 10000000000, 5000000000) #100 trillion UV
	holbean = Bean.new("Hole", false, 50000000000000000, 150000000000, 150000000000, 2000000000000, 1000000000000) #50 quadrillion UV
	espresso_hut = Building.new(2, 0, 1.1, 0.0, 500000, espresso_hut_sprite)
	bag_house = Building.new(2, 0, 1.5, 0.0, 1000000000, bag_house_sprite)
	vending_apartment = Building.new(2, 0, 2, 0.0,5000000000000 , vending_apartment_sprite)
	sugar_towers = Building.new(2, 0, 5, 0.0,100000000000000000 , sugar_towers_sprite)
	beans = [excelsa, robusta, arabica, liberica, kidney, evil, toe, magic, rainbow, holbean]
	upgrade_icons = [excelsa_upgrade_icon, robusta_upgrade_icon, arabica_upgrade_icon, liberica_upgrade_icon, kidney_upgrade_icon, evil_upgrade_icon, toe_upgrade_icon, magic_upgrade_icon, rainbow_upgrade_icon, holbean_upgrade_icon]
	upgrade_sprites = [excelsa_upgrade_sprite, robusta_upgrade_sprite, arabica_upgrade_sprite, liberica_upgrade_sprite, kidney_upgrade_sprite, evil_upgrade_sprite, toe_upgrade_sprite, magic_upgrade_sprite, rainbow_upgrade_sprite, holbean_upgrade_sprite]
	upgrade_labels = [excelsa_label, robusta_label, arabica_label, liberica_label, kidney_label, evil_label, toe_label, magic_label, rainbow_label, holbean_label]
	upgrades = [upgrade_excelsa, upgrade_robusta, upgrade_arabica, upgrade_liberica, upgrade_kidney, upgrade_evil, upgrade_toe, upgrade_magic, upgrade_rainbow, upgrade_holbean]
	building_shop_buttons = [building_one_button, building_two_button, building_three_button, building_four_button]
	buildings = [[building1, building2, building3, building4, building5], [building6, building7, building8, building9, building10],  
[building11, building12, building13, building14, building15], [building16, building17, building18, building19, building20],  
[building21, building22, building23, building24, building25]]
	update_all()
	print(espresso_hut.params())
	print(bag_house.params())
	print(vending_apartment.params())
	print(sugar_towers.params())

#func _process(delta) -> void:
	#if cursor_object != null:
		#cursor_object.global_position = get_global_mouse_position()


#>---INTERACTION FUNCTIONS---<#     i cant do this no mo... X[
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
	update_all()
	
func _on_upgrade_robusta_pressed() -> void:
	upgrade_bean(robusta)
	update_all()
	
func _on_upgrade_arabica_pressed() -> void:
	upgrade_bean(arabica)
	update_all()

func _on_upgrade_liberica_pressed() -> void:
	upgrade_bean(liberica)
	update_all()

func _on_upgrade_kidney_pressed() -> void:
	upgrade_bean(kidney)
	update_all()

func _on_upgrade_evil_pressed() -> void:
	upgrade_bean(evil)
	update_all()

func _on_upgrade_toe_pressed() -> void:
	upgrade_bean(toe)
	update_all()

func _on_upgrade_magic_pressed() -> void:
	upgrade_bean(magic)
	update_all()

func _on_upgrade_rainbow_pressed() -> void:
	upgrade_bean(rainbow)
	update_all()

func _on_upgrade_holbean_pressed() -> void:
	upgrade_bean(holbean)
	update_all()
	
func _on_building_one_button_pressed() -> void:
	if money.greateq(espresso_hut.building_cost) and map.count_if(0) != 0:
		print('ok')
		get_building(espresso_hut)
	else: print('kill yoself')
	update_all()
	#cursor_object = $Building_Menu/Building_Shop_Menu/ScrollContainer/VBoxContainer/Buy_Building_One/Building_One_Texture

func _on_building_two_button_pressed() -> void:
	if money.greateq(bag_house.building_cost) and map.count_if(0) != 0:
		print('ok')
		get_building(bag_house)
	else: print('kill yoself')
	update_all()

func _on_building_three_button_pressed() -> void:
	if money.greateq(vending_apartment.building_cost) and map.count_if(0) != 0:
		print('ok')
		get_building(vending_apartment)
	else: print('kill yoself')
	update_all()

func _on_building_four_button_pressed() -> void:
	if money.greateq(sugar_towers.building_cost) and map.count_if(0) != 0:
		print('ok')
		get_building(sugar_towers)
	else: print('kill yoself')
	update_all()

# unlocks beans
func _on_unlock_pressed() -> void:
	if beandex < beans.size():
		if (money.greateq(beans[beandex].unlock_value)):
			beans[beandex].unlocked = true
			upgrade_icons[beandex].texture = upgrade_sprites[beandex]
			money = money.subtract(beans[beandex].unlock_value)
			beandex += 1
			update_all()
#>---INTERACTION FUNCTIONS---<#


#>---MONEY FUNCTIONS---<#
# upgrades bean sell_value if you have enough money
func upgrade_bean(bean) -> void:
	if bean.unlocked && money.greateq(bean.upgrade_cost):
		money = money.subtract(bean.upgrade_cost)
		bean.upgrade_bean()

func get_building(template: Building) -> void:
	print(template.params(), template.building_texture)
	money = money.subtract(template.building_cost)
	var coords = [randi_range(0,4), randi_range(0,4)]
	while map.grid[coords[0]][coords[1]].position_type != 0:
		coords = [randi_range(0,4), randi_range(0,4)]
	map.place(template.params(), coords[0], coords[1])

# updates your money
func make_coffee() -> void:
	money = money.add(coffeeValue.multiply(map.multipliers))
#>---MONEY FUNCTIONS---<#


#>---UPDATE FUNCTIONS---<#
func update_all() -> void:
	update_coffee_value()
	update_money_text()
	update_unlock_text()
	update_upgrade_text()
	update_all_building_text()
	update_buildings()
	
	
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
		upgrade_labels[index].text = "%s Bean\nCurrent Value: $%s\nUpgrade: $%s\nLevel: %s" %[beans[index].Name, sell_value, upgrade_cost, beans[index].level]

func update_all_building_text() -> void:
	update_building_text("Espresso Hut", $Building_Menu/Building_Shop_Menu/ScrollContainer/VBoxContainer/Buy_Building_One/Building_One_Description, espresso_hut)
	update_building_text("Bag House", $Building_Menu/Building_Shop_Menu/ScrollContainer/VBoxContainer/Buy_Building_Two/Building_Two_Description, bag_house)
	update_building_text("Vending Apartment", $Building_Menu/Building_Shop_Menu/ScrollContainer/VBoxContainer/Buy_Building_Three/Building_Three_Description, vending_apartment)
	update_building_text("Sugar Towers", $Building_Menu/Building_Shop_Menu/ScrollContainer/VBoxContainer/Buy_Building_Four/Building_Four_Description, sugar_towers)

func update_building_text(buildingname: String, buildingtext: RichTextLabel, building: Building) -> void:
	buildingtext.text = "%s\nCost: $%s\nMultiplier: %s" %[buildingname, building.building_cost.condensed(), building.multiplier]

func update_buildings() -> void:
	for x in range(buildings.size()):
		var x_strip: Array = buildings[x]
		for y in range(x_strip.size()):
			var y_cell: Building = map.grid[x][y]
			match y_cell.position_type:
				0:
					buildings[x][y].texture = null
				1:
					buildings[x][y].texture = stand_sprite
					print("yerrp")
				_:
					match y_cell.multiplier:
						5.0: buildings[x][y].texture = sugar_towers_sprite
						2.0: buildings[x][y].texture = vending_apartment_sprite
						1.5: buildings[x][y].texture = bag_house_sprite
						1.1: buildings[x][y].texture = espresso_hut_sprite
#>---UPDATE FUNCTIONS---<#

func swap_check() -> void:
	if swap_queue.size() == 2:
		map.move(swap_queue[0][0], swap_queue[0][1], swap_queue[1][0], swap_queue[1][1])
		swap_queue = []
	update_all()

func _on_building_grid_block_1_pressed() -> void:
	swap_queue.append([0, 0])
	swap_check()
func _on_building_grid_block_2_pressed() -> void:
	swap_queue.append([0, 1])
	swap_check()
func _on_building_grid_block_3_pressed() -> void:
	swap_queue.append([0, 2])
	swap_check()
func _on_building_grid_block_4_pressed() -> void:
	swap_queue.append([0, 3])
	swap_check()
func _on_building_grid_block_5_pressed() -> void:
	swap_queue.append([0, 4])
	swap_check()
func _on_building_grid_block_6_pressed() -> void:
	swap_queue.append([1, 0])
	swap_check()
func _on_building_grid_block_7_pressed() -> void:
	swap_queue.append([1, 1])
	swap_check()
func _on_building_grid_block_8_pressed() -> void:
	swap_queue.append([1, 2])
	swap_check()
func _on_building_grid_block_9_pressed() -> void:
	swap_queue.append([1, 3])
	swap_check()
func _on_building_grid_block_10_pressed() -> void:
	swap_queue.append([1, 4])
	swap_check()
func _on_building_grid_block_11_pressed() -> void:
	swap_queue.append([2, 0])
	swap_check()
func _on_building_grid_block_12_pressed() -> void:
	swap_queue.append([2, 1])
	swap_check()
func _on_building_grid_block_13_pressed() -> void:
	swap_queue.append([2, 2])
	swap_check()
func _on_building_grid_block_14_pressed() -> void:
	swap_queue.append([2, 3])
	swap_check()
func _on_building_grid_block_15_pressed() -> void:
	swap_queue.append([2, 4])
	swap_check()
func _on_building_grid_block_16_pressed() -> void:
	swap_queue.append([3, 0])
	swap_check()
func _on_building_grid_block_17_pressed() -> void:
	swap_queue.append([3, 1])
	swap_check()
func _on_building_grid_block_18_pressed() -> void:
	swap_queue.append([3, 2])
	swap_check()
func _on_building_grid_block_19_pressed() -> void:
	swap_queue.append([3, 3])
	swap_check()
func _on_building_grid_block_20_pressed() -> void:
	swap_queue.append([3, 4])
	swap_check()
func _on_building_grid_block_21_pressed() -> void:
	swap_queue.append([4, 0])
	swap_check()
func _on_building_grid_block_22_pressed() -> void:
	swap_queue.append([4, 1])
	swap_check()
func _on_building_grid_block_23_pressed() -> void:
	swap_queue.append([4, 2])
	swap_check()
func _on_building_grid_block_24_pressed() -> void:
	swap_queue.append([4, 3])
	swap_check()
func _on_building_grid_block_25_pressed() -> void:
	swap_queue.append([4, 4])
	swap_check()
