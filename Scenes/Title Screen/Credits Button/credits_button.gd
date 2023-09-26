extends Button

func _on_CreditsButton_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Credits/credits.tscn")
