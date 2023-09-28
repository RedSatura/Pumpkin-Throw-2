extends Button

onready var game_data = load("user://Data/game_data.tres") as GameData

func _on_Button_pressed():
	game_data.money += 10000
	ShopEventBus.emit_signal("update_money_label", game_data.money)
	var _save_status = ResourceSaver.save("user://Data/game_data.tres", game_data)
