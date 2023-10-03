extends TextureRect

func _ready():
	if SaveManager.game_data.statistics.best_distance == 0:
		self.set_global_position(Vector2(-64, 0))
	else:
		self.set_global_position(Vector2(SaveManager.game_data.statistics.best_actual_distance, 0))
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_pumpkin_position", self, "update_x_position")
	
func update_x_position(pos):
	self.rect_position.y = pos.y - 1000
