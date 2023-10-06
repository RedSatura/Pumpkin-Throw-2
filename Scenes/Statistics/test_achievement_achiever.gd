extends Button

func _on_TestAchievementAchiever_pressed():
	SaveManager.game_data.achievements.test_achievement = true
	SaveManager.save_data()
