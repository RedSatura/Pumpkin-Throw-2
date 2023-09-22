extends TextureRect

func _ready():
	var game_data = load("user://Data/game_data.tres") as GameData
	if game_data != null:
		if game_data.best_actual_distance == 0:
			self.set_global_position(Vector2(-64, 0))
		else:
			self.set_global_position(Vector2(game_data.best_actual_distance, 0))
	LevelEventBus.connect("get_pumpkin_position", self, "update_x_position")

func _process(delta):
	pass
	
func update_x_position(pos):
	self.rect_position.y = pos.y - 1000
