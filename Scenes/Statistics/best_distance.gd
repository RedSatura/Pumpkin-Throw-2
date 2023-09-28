extends Label

func _ready():
	var game_data = load("user://Data/game_data.tres") as GameData
	self.text = "Best Distance: " + str(game_data.best_distance) + " meters"
	
