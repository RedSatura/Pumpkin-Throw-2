extends VBoxContainer

export(int) var cost = 0
export(String) var title = ""
export(String, MULTILINE) var description = ""
export(String, FILE) var image_path = "res://icon.png"
export(String, FILE) var pumpkin_texture_path = ""

onready var tex = $TextureRect
onready var price_label = $PriceLabel

func _ready():
	if cost <= 0:
		cost = 0
	price_label.text = "$" + str(comma_number(cost))

func _on_Item_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			ShopEventBus.emit_signal("update_item_display", image_path)
			ShopEventBus.emit_signal("update_item_display_title", title)
			ShopEventBus.emit_signal("update_item_display_description", description)
			ShopEventBus.emit_signal("update_equip_button", pumpkin_texture_path, cost)

func comma_number(num):
	var comma_num = ""
	var mod = str(num).length() % 3
	for x in range(0, str(num).length()):
		if x != 0 && x % 3 == mod:
			comma_num += ","
		comma_num += str(num)[x]
	return comma_num
