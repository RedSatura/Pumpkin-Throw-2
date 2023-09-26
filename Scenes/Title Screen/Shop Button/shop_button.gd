extends Button

func _on_ShopButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Shop/shop.tscn")
