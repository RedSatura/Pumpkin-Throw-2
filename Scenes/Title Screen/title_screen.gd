extends Node2D

var game_data = load("user://Data/game_data.tres") as GameData

func _ready():
	var fire_cannon_key = InputEventKey.new()
	fire_cannon_key.set_scancode(OptionsData.load_file("Inputs", "CannonFire", 88))
	var dash_key = InputEventKey.new()
	dash_key.set_scancode(OptionsData.load_file("Inputs", "Dash", 90))
	var fall_key = InputEventKey.new()
	fall_key.set_scancode(OptionsData.load_file("Inputs", "Fall", 88))
	InputMap.action_erase_events("cannon_fire")
	InputMap.action_add_event("cannon_fire", fire_cannon_key)
	InputMap.action_erase_events("dash")
	InputMap.action_add_event("dash", dash_key)
	InputMap.action_erase_events("fall")
	InputMap.action_add_event("fall", fall_key)
