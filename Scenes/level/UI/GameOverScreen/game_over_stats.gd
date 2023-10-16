extends Label

func _ready():
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_current_pumpkin_distance", self, "update_label")
	
func update_label(dist):
	self.text = "Distance Travelled: "
	if dist >= 1000:
		var km_dist: float = dist / 1000
		self.text += str(km_dist) + " kilometers"
	else:
		self.text += str(dist) + " meters"
