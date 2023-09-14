extends Area2D

func _ready():
	LevelEventBus.connect("get_current_pumpkin_distance", self, "check_pumpkin_position")

func check_pumpkin_position(pos):
	if pos > self.global_position.x + 25000:
		queue_free()
