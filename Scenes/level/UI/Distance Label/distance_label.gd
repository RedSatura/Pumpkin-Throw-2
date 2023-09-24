extends Label

func _ready():
	LevelEventBus.connect("get_current_pumpkin_distance", self, "update_label")
	LevelEventBus.connect("show_level_uis", self, "show_mode")
	self.text = "Distance: 0 meters"
	
func update_label(distance):
	self.text = "Distance: " + str(distance) + " meters"
	
func show_mode(status):
	set_visible(status)
