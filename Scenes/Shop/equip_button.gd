extends Button

enum ButtonState {
	DISABLED,
	BUYABLE,
	EQUIPPABLE,
	EQUIPPED,
}

var button_state = ButtonState.DISABLED

var texture_path = ""
var item_cost = 0

func _ready():
# warning-ignore:return_value_discarded
	ShopEventBus.connect("update_equip_button", self, "update_equip_button")
	set_disabled(true)

func update_equip_button(path, cost, _milestone_number):
	if !ResourceLoader.exists(path):
		if path == "invisible_pumpkin":
			if SaveManager.game_data.current.money < cost:
				self.set_text("Too expensive!")
				set_disabled(true)
				button_state = ButtonState.DISABLED
			elif path == SaveManager.game_data.current.pumpkin_texture_path:
				set_disabled(true)
				self.set_text("Equipped!")
				button_state = ButtonState.EQUIPPED
			else:
				set_disabled(false)
				self.set_text("Buy!")
				texture_path = path
				item_cost = cost
				button_state = ButtonState.BUYABLE
		else:
			set_disabled(true)
			self.set_text("File doesn't exist!")
	else:
		if SaveManager.game_data.current.money < cost:
			self.set_text("Too expensive!")
			set_disabled(true)
			button_state = ButtonState.DISABLED
		elif path == SaveManager.game_data.current.pumpkin_texture_path:
			set_disabled(true)
			self.set_text("Equipped!")
			button_state = ButtonState.EQUIPPED
		else:
			set_disabled(false)
			self.set_text("Buy!")
			texture_path = path
			item_cost = cost
			button_state = ButtonState.BUYABLE

func _on_EquipButton_pressed():
	match button_state:
		ButtonState.DISABLED:
			pass
		ButtonState.BUYABLE:
			SaveManager.game_data.current.pumpkin_texture_path = texture_path
			SaveManager.game_data.current.money -= item_cost
			SaveManager.save_data()
			button_state = ButtonState.EQUIPPED
			set_disabled(true)
			ShopEventBus.emit_signal("update_money_label", SaveManager.game_data.current.money)
		ButtonState.EQUIPPABLE:
			SaveManager.game_data.current.pumpkin_texture_path = texture_path
			SaveManager.save_data()
		ButtonState.EQUIPPED:
			pass
