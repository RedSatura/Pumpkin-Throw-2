extends Label

func _ready():
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_current_pumpkin_distance", self, "update_label")
	
func update_label(dist):
	self.text = "Distance Travelled: " + str(dist) + " meters. Your best distance: " + str(SaveManager.game_data.statistics.best_distance) + " meters."
