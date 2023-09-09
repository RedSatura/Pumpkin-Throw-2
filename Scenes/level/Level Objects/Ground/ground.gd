extends StaticBody2D

func _ready():
	LevelEventBus.connect("get_current_pumpkin_distance", self, "update_position")
	
func update_position(pos):
	self.global_position.x = pos
	

