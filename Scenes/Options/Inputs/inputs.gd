extends Button

var key_changeable = false
var action_string = ""

func _on_Fire_Cannon_pressed():
	action_string = "cannon_fire"
	key_changeable = true

func _on_Dash_pressed():
	action_string = "dash"
	key_changeable = true
	
func _on_Fall_pressed():
	action_string = "fall"
	key_changeable = true

func change_key(new_key):
	InputMap.action_erase_events(action_string)
	InputMap.action_add_event(action_string, new_key)
	self.set_text(OS.get_scancode_string(new_key.physical_scancode))
	key_changeable = false
	self.set_pressed(false)

func _input(event):
	if event is InputEventKey && key_changeable:
		change_key(event)


