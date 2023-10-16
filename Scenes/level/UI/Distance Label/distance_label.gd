extends Label

func _ready():
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_current_pumpkin_distance", self, "update_label")
# warning-ignore:return_value_discarded
	LevelEventBus.connect("show_level_uis", self, "show_mode")
	self.text = "Distance: 0 meters"
	
func update_label(distance):
	self.text = "Distance: "
	if distance >= 1000:
		var km_distance: float = distance / 1000
		self.text += str(stepify(km_distance, 0.001)) + " kilometers"
	else:
		self.text += str(distance) + " meters"
	
func show_mode(status):
	set_visible(status)

