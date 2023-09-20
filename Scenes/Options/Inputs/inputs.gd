extends Button

export var button_name = ""

var key_changeable = false
var action_string = ""

onready var game_data = load("user://Data/game_data.tres") as GameData

func _ready():
	match button_name:
		"Fire Cannon":
			self.set_text(OS.get_scancode_string(game_data.input_fire_cannon.physical_scancode))
		"Dash":
			self.set_text(OS.get_scancode_string(game_data.input_dash.physical_scancode))
		"Fall":
			self.set_text(OS.get_scancode_string(game_data.input_fall.physical_scancode))
	OptionsEventBus.connect("toggle_buttons", self, "toggle_buttons")

func _on_Fire_Cannon_pressed():
	if self.pressed:
		OptionsEventBus.emit_signal("toggle_buttons", false)
		self.set_pressed(true)
		action_string = "cannon_fire"
		key_changeable = true
	else:
		key_changeable = false

func _on_Dash_pressed():
	if self.pressed:
		OptionsEventBus.emit_signal("toggle_buttons", false)
		self.set_pressed(true)
		action_string = "dash"
		key_changeable = true
	else:
		key_changeable = false

func _on_Fall_pressed():
	if self.pressed:
		OptionsEventBus.emit_signal("toggle_buttons", false)
		self.set_pressed(true)
		action_string = "fall"
		key_changeable = true
	else:
		key_changeable = false

func change_key(new_key):
	key_changeable = false
	InputMap.action_erase_events(action_string)
	InputMap.action_add_event(action_string, new_key)
	match action_string:
		"cannon_fire":
			game_data.input_fire_cannon = new_key
		"dash":
			game_data.input_dash = new_key
		"fall":
			game_data.input_fall = new_key
	ResourceSaver.save("user://Data/game_data.tres", game_data)
	self.set_text(OS.get_scancode_string(new_key.physical_scancode))
	self.set_pressed(false)

func _input(event):
	if event is InputEventKey && key_changeable:
		change_key(event)

func toggle_buttons(status):
	self.set_pressed(status)
	key_changeable = status
