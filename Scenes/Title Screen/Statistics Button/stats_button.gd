extends Button

func _on_StatsButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Statistics/statistics.tscn")
