extends Button

func _on_HelpButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Help/help.tscn")
