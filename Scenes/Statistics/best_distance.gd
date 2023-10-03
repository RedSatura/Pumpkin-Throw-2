extends Label

func _ready():
	self.text = "Best Distance: " + str(SaveManager.game_data.statistics.best_distance) + " meters"
	
