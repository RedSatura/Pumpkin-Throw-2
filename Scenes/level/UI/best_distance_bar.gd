extends TextureRect

func _ready():
	LevelEventBus.connect("get_pumpkin_position", self, "update_x_position")

func _process(delta):
	self.rect_position.x = -64
	
func update_x_position(pos):
	self.rect_position.y = pos.y - 1000
