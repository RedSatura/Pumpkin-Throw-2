extends Area2D

func _ready():
	LevelEventBus.connect("get_pumpkin_position", self, "check_pumpkin_position")
	
func check_pumpkin_position(pos):
	if pos.x > self.global_position.x + 20000:
		queue_free()
