extends Button

enum ButtonState {
	DISABLED,
	BUYABLE,
	EQUIPPABLE,
	EQUIPPED,
}

var button_state = ButtonState.DISABLED

func _ready():
# warning-ignore:return_value_discarded
	ShopEventBus.connect("update_equip_button", self, "update_equip_button")
	set_disabled(true)

func update_equip_button(path):
	var dir = Directory.new()
	if dir.file_exists(path):
		set_disabled(false)
		button_state = ButtonState.BUYABLE
	else:
		set_disabled(true)
		button_state = ButtonState.DISABLED

func _on_EquipButton_pressed():
	match button_state:
		ButtonState.DISABLED:
			pass
		ButtonState.BUYABLE:
			pass
		ButtonState.EQUIPPABLE:
			pass
		ButtonState.EQUIPPED:
			pass
