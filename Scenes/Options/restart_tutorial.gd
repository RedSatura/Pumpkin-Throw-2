extends Button

func _on_RestartTutorial_pressed():
	SaveManager.game_data.special.tutorial_active = true
	SaveManager.save_data()
