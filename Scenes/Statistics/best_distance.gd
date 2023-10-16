extends Label

func _ready():
	self.text = "Best Distance: "
	if SaveManager.game_data.statistics.best_distance >= 1000:
		var km_dist: float = SaveManager.game_data.statistics.best_distance / 1000
		self.text += str(stepify(km_dist, 0.001)) + " kilometers"
	else:
		self.text += str(SaveManager.game_data.statistics.best_distance) + " meters"
	
