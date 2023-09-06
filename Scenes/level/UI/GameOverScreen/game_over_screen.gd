extends Panel

onready var show_game_over_timer = $ShowGameOverScreen

func _ready():
	LevelEventBus.connect("show_game_over", self, "set_visibility")
	self.visible = false

func set_visibility(delay):
	if delay != null:
		show_game_over_timer.start(delay)
	else:
		self.visible = true

func _on_ShowGameOverScreen_timeout():
	self.visible = true
