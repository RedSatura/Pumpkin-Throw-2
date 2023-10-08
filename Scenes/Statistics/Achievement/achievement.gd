extends VBoxContainer

export(String, FILE) var achievement_texture = ""
export(String) var save_achievement_title = ""
export (String) var achievement_title = ""
export (String, MULTILINE) var achievement_description = ""

onready var texture_rect = $TextureRect
onready var label = $Label

func _ready():
	texture_rect.texture = load(achievement_texture)
	label.text = achievement_title
	if SaveManager.game_data["achievements"][save_achievement_title]:
		texture_rect.self_modulate = Color(1, 1, 0, 1)
	else:
		texture_rect.self_modulate = Color(1, 1, 1, 1)

func _on_Achievement_gui_input(event):
	if event is InputEventMouseButton:
		if event.pressed:
			StatisticsEventBus.emit_signal("send_achievement_data", achievement_texture, achievement_title, achievement_description, save_achievement_title)
