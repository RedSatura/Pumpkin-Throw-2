extends StaticBody2D

onready var base_pivot = $BasePivot
onready var base = $BasePivot/Base

func _ready():
	LevelEventBus.connect("get_current_pumpkin_distance", self, "check_pumpkin_position")
	self.rotation_degrees = rand_range(-10, 20)
	base_pivot.rotation_degrees = self.rotation_degrees * -1.0
	base.rect_position.x = -32
	base.rect_size = Vector2(64, 575 - self.position.y)
	
func check_pumpkin_position(pos):
	if pos > self.global_position.x + 25000:
		queue_free()
