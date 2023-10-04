extends Node2D

func _ready():
	SaveManager.load_data()
	load_saved_inputs()

func load_saved_inputs():
	var cannon_fire_key = InputEventKey.new()
	cannon_fire_key.set_scancode(OptionsData.load_file("Inputs", "CannonFire", 88))
	var dash_key = InputEventKey.new()
	dash_key.set_scancode(OptionsData.load_file("Inputs", "Dash", 90))
	var fall_key = InputEventKey.new()
	fall_key.set_scancode(OptionsData.load_file("Inputs", "Fall", 88))
	var cannon_up_key = InputEventKey.new()
	cannon_up_key.set_scancode(OptionsData.load_file("Inputs", "CannonUp", 16777232))
	var cannon_down_key = InputEventKey.new()
	cannon_down_key.set_scancode(OptionsData.load_file("Inputs", "CannonDown", 16777234))
	InputMap.action_erase_events("cannon_fire")
	InputMap.action_add_event("cannon_fire", cannon_fire_key)
	InputMap.action_erase_events("dash")
	InputMap.action_add_event("dash", dash_key)
	InputMap.action_erase_events("fall")
	InputMap.action_add_event("fall", fall_key)
	InputMap.action_erase_events("cannon_up")
	InputMap.action_add_event("cannon_up", cannon_up_key)
	InputMap.action_erase_events("cannon_down")
	InputMap.action_add_event("cannon_down", cannon_down_key)
