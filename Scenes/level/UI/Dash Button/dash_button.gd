extends TextureButton

onready var polygon_2d = $Polygon2D

func _ready():
	LevelEventBus.connect("check_dash_cooldown", self, "update_button")

func update_button(status):
	if status:
		polygon_2d.color = Color(0.56, 0.93, 0.56, 1)
	else:
		polygon_2d.color = Color(0.86, 0.08, 0.24, 1)
