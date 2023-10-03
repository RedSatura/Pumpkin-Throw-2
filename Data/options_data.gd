extends Node

var save_path = "user://Data/options_data.cfg"
var config = ConfigFile.new()
var load_response = config.load(save_path)

func save_file(section, key, value):
	config.set_value(section, key, value)
	config.save(save_path)

func load_file(section, key, value):
	return config.get_value(section, key, value)
