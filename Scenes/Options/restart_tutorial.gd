extends Button

var game_data = load("user://Data/game_data.tres") as GameData

func _on_RestartTutorial_pressed():
	game_data.tutorial_active = true
	var _game_data_status = ResourceSaver.save("user://Data/game_data.tres", game_data)
