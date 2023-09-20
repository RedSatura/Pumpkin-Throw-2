extends Node2D

var game_data = load("user://Data/game_data.tres") as GameData

func _ready():
	InputMap.action_erase_events("cannon_fire")
	InputMap.action_add_event("cannon_fire", game_data.input_fire_cannon)
	InputMap.action_erase_events("dash")
	InputMap.action_add_event("dash", game_data.input_dash)
	InputMap.action_erase_events("fall")
	InputMap.action_add_event("fall", game_data.input_fall)
