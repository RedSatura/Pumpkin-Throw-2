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
var item_name = ""

func _ready():
# warning-ignore:return_value_discarded
	ShopEventBus.connect("update_equip_button", self, "update_equip_button")
	set_disabled(true)

func update_equip_button(path, cost, i_name, _milestone_number):
	item_name = i_name
	
	if !ResourceLoader.exists(path):
		if path == "invisible_pumpkin":	
			button_equip_status(path, cost, i_name)
		else:
			set_disabled(true)
			self.set_text("File doesn't exist!")
	else:
		button_equip_status(path, cost, i_name)

func _on_EquipButton_pressed():
	match button_state:
		ButtonState.DISABLED:
			pass
		ButtonState.BUYABLE:
			SaveManager.game_data.current.pumpkin_texture_path = texture_path
			SaveManager.game_data.current.money -= item_cost
			SaveManager.game_data["equipped"][item_name] = true
			SaveManager.save_data()
			button_state = ButtonState.EQUIPPED
			self.set_text("Equipped!")
			set_disabled(true)
			ShopEventBus.emit_signal("update_money_label", SaveManager.game_data.current.money)
		ButtonState.EQUIPPABLE:
			SaveManager.game_data.current.pumpkin_texture_path = texture_path
			SaveManager.save_data()
			set_disabled(true)
			self.set_text("Equipped!")
			button_state = ButtonState.EQUIPPED
		ButtonState.EQUIPPED:
			pass
			
func button_equip_status(path_1, cost_1, item_name_1):
	if path_1 == SaveManager.game_data.current.pumpkin_texture_path:
		set_disabled(true)
		self.set_text("Equipped!")
		button_state = ButtonState.EQUIPPED
	elif SaveManager.game_data.equipped[item_name_1]:
		set_disabled(false)
		self.set_text("Equip!")
		texture_path = path_1
		item_cost = cost_1
		button_state = ButtonState.EQUIPPABLE
	elif SaveManager.game_data.current.money < cost_1:
		self.set_text("Too expensive!")
		set_disabled(true)
		button_state = ButtonState.DISABLED
	else:
		set_disabled(false)
		self.set_text("Buy!")
		texture_path = path_1
		item_cost = cost_1
		button_state = ButtonState.BUYABLE
