extends Label

func _ready():
	LevelEventBus.connect("get_current_pumpkin_distance", self, "update_label")
	self.text = "0 m"
	
func update_label(distance):
	self.text = "Distance: " + str(round(distance / 100)) + " m"
