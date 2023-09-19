extends StaticBody2D

onready var base_pivot = $BasePivot
onready var base = $BasePivot/Base

func _ready():
	LevelEventBus.connect("get_pumpkin_position", self, "check_pumpkin_position")
	self.rotation_degrees = rand_range(-10, 20)
	base_pivot.rotation_degrees = self.rotation_degrees * -1.0
	base.rect_position.x = -32
	base.rect_size = Vector2(64, 575 - self.position.y)
	
func check_pumpkin_position(pos):
	if pos.x > self.global_position.x + 20000:
		queue_free()
