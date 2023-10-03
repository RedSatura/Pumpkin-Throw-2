extends Label

func _ready():
	self.text = "Total Money: $" + comma_num(SaveManager.game_data.statistics.total_money)
	
func comma_num(num):
	var comma_num = ""
	var mod = str(num).length() % 3
	for x in range(0, str(num).length()):
		if x != 0 && x % 3 == mod:
			comma_num += ","
		comma_num += str(num)[x]
	return comma_num
