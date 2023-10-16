extends Label

func _ready():
	self.text = "Total Distance: "
	if SaveManager.game_data.statistics.total_distance >= 1000:
		self.text += str(SaveManager.game_data.statistics.total_distance / 1000) + " kilometers"
	else:
		self.text += str(SaveManager.game_data.statistics.total_distance) + " meters"
