extends VBoxContainer

onready var tex = $TextureRect

func _ready():
	print(tex.texture)

func _on_Item_gui_input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			ShopEventBus.emit_signal("update_item_display", tex.texture)
