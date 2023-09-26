extends Area2D

func _ready():
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_pumpkin_position", self, "check_pumpkin_position")

func check_pumpkin_position(pos):
	if pos.x > self.global_position.x + 25000:
		queue_free()
