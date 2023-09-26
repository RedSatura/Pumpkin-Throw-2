extends Label

func _ready():
# warning-ignore:return_value_discarded
	LevelEventBus.connect("update_money_received", self, "update_label")
	
func update_label(money):
	self.text = "Money Received: $" + str(comma_number(money))
	
func comma_number(num):
	var comma_num = ""
	var mod = str(num).length() % 3
	for x in range(0, str(num).length()):
		if x != 0 && x % 3 == mod:
			comma_num += ","
		comma_num += str(num)[x]
	return comma_num
