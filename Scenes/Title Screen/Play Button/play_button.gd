extends Button

func _on_PlayButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Level/level.tscn")

func _on_RestartButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Level/level.tscn")
