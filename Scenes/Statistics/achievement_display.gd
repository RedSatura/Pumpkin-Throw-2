extends VBoxContainer

export var achievement_name = ""

onready var texture_rect = $TextureRect
onready var name_label = $AchievementName
onready var description_label = $AchievementDescription

func _ready():
# warning-ignore:return_value_discarded
	StatisticsEventBus.connect("send_achievement_data", self, "update_display")
	
func update_display(tex, ach_name, ach_desc, ach_save_title):
	if SaveManager.game_data["achievements"][ach_save_title]:
		texture_rect.material.set_shader_param("achieved_color", Color(1.0, 0.843, 0.0, 1.0))
	else:
		texture_rect.material.set_shader_param("achieved_color", Color(1.0, 1.0, 1.0, 1.0))
	texture_rect.texture = load(tex)
	name_label.text = ach_name
	description_label.text = ach_desc
