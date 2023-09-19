extends Label

func _ready():
	LevelEventBus.connect("get_current_pumpkin_distance", self, "update_label")
	
func update_label(dist):
	var game_data = load("user://Data/game_data.tres") as GameData
	self.text = "Distance Travelled: " + str(dist) + " meters. Your best distance: " + str(game_data.best_distance) + " meters."
