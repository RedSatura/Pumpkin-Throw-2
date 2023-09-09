extends StaticBody2D

func _ready():
	LevelEventBus.connect("get_current_pumpkin_distance", self, "check_pumpkin_position")
	self.rotation_degrees = rand_range(-10, 20)
	
func check_pumpkin_position(pos):
	if pos > self.global_position.x + 5000:
		queue_free()
