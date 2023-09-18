extends Label

func _ready():
	LevelEventBus.connect("get_current_pumpkin_distance", self, "update_label")
	self.text = "Distance: 0 meters"
	
func update_label(distance):
	self.text = "Distance: " + str(distance) + " meters"
