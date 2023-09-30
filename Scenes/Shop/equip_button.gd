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

onready var game_data = load("user://Data/game_data.tres") as GameData

func _ready():
# warning-ignore:return_value_discarded
	ShopEventBus.connect("update_equip_button", self, "update_equip_button")
	set_disabled(true)

func update_equip_button(path, cost, _milestone_number):
	var dir = Directory.new()
	dir.open("user://")
	if !dir.file_exists(path):
		if path == "invisible_pumpkin":
			if game_data.money < cost:
				self.set_text("Too expensive!")
				set_disabled(true)
				button_state = ButtonState.DISABLED
			elif path == game_data.pumpkin_texture_path:
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
			self.set_text("INVALID FILEPATH")
	else:
		if game_data.money < cost:
			self.set_text("Too expensive!")
			set_disabled(true)
			button_state = ButtonState.DISABLED
		elif path == game_data.pumpkin_texture_path:
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
			game_data.pumpkin_texture_path = texture_path
			game_data.money -= item_cost
			button_state = ButtonState.EQUIPPED
			set_disabled(true)
			ShopEventBus.emit_signal("update_money_label", game_data.money)
			var _save_status = ResourceSaver.save("user://Data/game_data.tres", game_data)
		ButtonState.EQUIPPABLE:
			game_data.pumpkin_texture_path = texture_path
			set_disabled(true)
			var _save_status = ResourceSaver.save("user://Data/game_data.tres", game_data)
		ButtonState.EQUIPPED:
			pass
