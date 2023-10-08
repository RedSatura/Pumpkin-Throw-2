extends Node

var save_path = "user://Data/options_data.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)

func save_file(section, key, value):
	config.set_value(section, key, value)
	config.save(save_path)

func load_file(section, key, value):
	return config.get_value(section, key, value)

func reset_data():
	OptionsData.save_file("Inputs", "CannonFire", 88)
	OptionsData.save_file("Inputs", "Dash", 90)
	OptionsData.save_file("Inputs", "Fall", 88)
	OptionsData.save_file("Inputs", "CannonUp", 16777232)
	OptionsData.save_file("Inputs", "CannonDown", 16777234)
