extends TextureButton

onready var polygon_2d = $Polygon2D

func _ready():
	LevelEventBus.connect("check_fall_cooldown", self, "update_button")
	LevelEventBus.connect("show_level_uis", self, "show_mode")
	self.visible = false
	polygon_2d.color = Color(0.86, 0.08, 0.24, 1)

func update_button(status):
	if status:
		polygon_2d.color = Color(0.56, 0.93, 0.56, 1)
	else:
		polygon_2d.color = Color(0.86, 0.08, 0.24, 1)

func show_mode(status):
	set_visible(status)
