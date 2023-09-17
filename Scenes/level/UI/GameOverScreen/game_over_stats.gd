extends Label

func _ready():
	LevelEventBus.connect("get_current_pumpkin_distance", self, "update_label")
	
func update_label(dist):
	self.text = "Distance Travelled: " + str(abs(round((dist - 96) / 250))) + " meters"
