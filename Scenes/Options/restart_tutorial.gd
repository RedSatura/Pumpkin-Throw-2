extends Button

var game_data = load("user://Data/game_data.tres") as GameData

func _on_RestartTutorial_pressed():
	game_data.tutorial_active = true
	ResourceSaver.save("user://Data/game_data.tres", game_data)
