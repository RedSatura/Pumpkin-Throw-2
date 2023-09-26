extends Label

func _ready():
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_current_pumpkin_distance", self, "update_label")
# warning-ignore:return_value_discarded
	LevelEventBus.connect("show_level_uis", self, "show_mode")
	self.text = "Distance: 0 meters"
	
func update_label(distance):
	self.text = "Distance: " + str(distance) + " meters"
	
func show_mode(status):
	set_visible(status)
