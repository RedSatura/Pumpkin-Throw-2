extends VBoxContainer

export(String, FILE) var achievement_texture = ""

onready var texture_rect = $TextureRect

func _ready():
	texture_rect.texture = load(achievement_texture)

func _on_Achievement_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			StatisticsEventBus.emit_signal("send_achievement_data")
