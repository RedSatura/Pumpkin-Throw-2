extends Label

func _ready():
# warning-ignore:return_value_discarded
	LevelEventBus.connect("show_level_uis", self, "show_mode")
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_pumpkin_velocity", self, "update_label")
	self.visible = false
	
func update_label(velocity):
	self.text = "Speed: " + str("%3.2f" % stepify(convert_distance_to_meters(velocity.x), 0.01)) + " m/s"
	
func show_mode(status):
	set_visible(status)

func convert_distance_to_meters(dist):
	return (dist - 96) / 250
