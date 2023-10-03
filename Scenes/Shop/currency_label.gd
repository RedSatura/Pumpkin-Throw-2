extends Label

func _ready():
# warning-ignore:return_value_discarded
	ShopEventBus.connect("update_money_label", self, "update_money_label")
	self.text = "$" + comma_number(SaveManager.game_data.current.money)

func comma_number(num):
	var comma_num = ""
	var mod = str(num).length() % 3
	for x in range(0, str(num).length()):
		if x != 0 && x % 3 == mod:
			comma_num += ","
		comma_num += str(num)[x]
	return comma_num
	
func update_money_label(amount):
	self.text = "$" + comma_number(amount)
