extends VBoxContainer

export(int) var cost = 0
export(String) var title = ""
export(String, MULTILINE) var description = ""
export(String, FILE) var image_path = ""
export(String, FILE) var pumpkin_texture_path = ""
#this will be used to check if an item is equipped
export(String) var item_name = ""
export(int) var milestone_number = 0

onready var tex = $TextureRect
onready var price_label = $PriceLabel

func _ready():
	if cost <= 0:
		cost = 0
	price_label.text = "$" + str(comma_number(cost))
	tex.texture = load(image_path)

func _on_Item_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			ShopEventBus.emit_signal("update_item_display", image_path)
			ShopEventBus.emit_signal("update_item_display_title", title)
			ShopEventBus.emit_signal("update_item_display_description", description)
			ShopEventBus.emit_signal("update_equip_button", pumpkin_texture_path, cost, item_name, milestone_number)

func comma_number(num):
	var comma_num = ""
	var mod = str(num).length() % 3
	for x in range(0, str(num).length()):
		if x != 0 && x % 3 == mod:
			comma_num += ","
		comma_num += str(num)[x]
	return comma_num
