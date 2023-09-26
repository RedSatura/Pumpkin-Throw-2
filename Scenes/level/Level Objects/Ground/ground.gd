extends StaticBody2D

func _ready():
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_pumpkin_position", self, "update_position")
	
func update_position(pos):
	self.global_position.x = pos.x
	

