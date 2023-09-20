extends Label

func _ready():
	var game_data = load("user://Data/game_data.tres") as GameData
	self.text = "$" + comma_number(game_data.money)

func comma_number(num):
	var comma_num = ""
	var mod = str(num).length() % 3
	for x in range(0, str(num).length()):
		if x != 0 && x % 3 == mod:
			comma_num += ","
		comma_num += str(num)[x]
	return comma_num
