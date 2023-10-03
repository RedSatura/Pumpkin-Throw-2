extends Button

func _on_Button_pressed():
	SaveManager.game_data.current.money += 10000
	ShopEventBus.emit_signal("update_money_label", SaveManager.game_data.current.money)
	SaveManager.save_data()
