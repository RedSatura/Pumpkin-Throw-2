extends Sprite

func _ready():
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_pumpkin_position", self, "update_color")
	
func update_color(pos):
	self.modulate = Color(0.0,  1 - (-pos.y + 600) / 9230, 1 - (-pos.y + 600) / 6315, 1.0)
