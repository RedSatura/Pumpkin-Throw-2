extends Button

func _on_OptionsButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Options/options.tscn")
