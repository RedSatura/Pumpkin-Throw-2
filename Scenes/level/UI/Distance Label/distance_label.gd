extends Label

func _ready():
	LevelEventBus.connect("get_current_pumpkin_distance", self, "update_label")
	self.text = "Distance: 0 m"
	
func update_label(distance):
	self.text = "Distance: " + str(abs(round((distance - 96) / 250))) + " m"
