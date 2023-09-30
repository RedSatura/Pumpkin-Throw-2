extends VBoxContainer

func _ready():
# warning-ignore:return_value_discarded
	StatisticsEventBus.connect("send_achievement_data", self, "update_display")
	
func update_display():
	pass
