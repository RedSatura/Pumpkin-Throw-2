extends Node

var save_path = "user://save_data.json"

var default_game_data = {
	"statistics" : {
		"best_distance": 0,
		"best_actual_distance": 0,
		"total_money": 0,
	},
	"current" : {
		"money": 0,
		
		"pumpkin_texture_path": "res://Scenes/Shop/Textures/test_pumpkin_texture.png",
	},
	"equipped" : {
		"default_pumpkin": true,
		"icon.png": false,
		"invisible_pumpkin": false,
	},
	"special": {
		"tutorial_active": true,
	},
	"achievements": {
		"test_achievement": false,
		#distance-related achievements
		"100m_thrown": false,
		"500m_thrown": false,
		"1km_thrown": false,
		"marathon_thrown": false,
		
		"invisible_kilometer": false,
		"10000_money": false,
	},
}

var game_data = {
	
}

func _ready():
	var dir = Directory.new()
	if dir.dir_exists("user://Data"):
		dir.open("user://")
		dir.make_dir("Data")
	load_data()
		
func save_data():
	var savefile = File.new()
	
	savefile.open(save_path, File.WRITE)
	
	savefile.store_line(to_json(game_data))
	
	savefile.close()
	
func load_data():
	var savefile = File.new()
	
	if !savefile.file_exists(save_path):
		reset_data()
		return
		
	savefile.open(save_path, File.READ)
	
	var text = savefile.get_as_text()
	
	game_data = parse_json(text)
	
	savefile.close()
	
func reset_data():
	game_data = default_game_data.duplicate(true)
	save_data()
