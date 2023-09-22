extends Button

export var button_name = ""

var key_changeable = false
var action_string = ""

onready var game_data = load("user://Data/game_data.tres") as GameData

func _ready():
	match button_name:
		"Fire Cannon":
			self.set_text(OS.get_scancode_string(OptionsData.load_file("Inputs", "CannonFire", 88)))
		"Dash":
			self.set_text(OS.get_scancode_string(OptionsData.load_file("Inputs", "Dash", 90)))
		"Fall":
			self.set_text(OS.get_scancode_string(OptionsData.load_file("Inputs", "Fall", 88)))
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
			OptionsData.save_file("Inputs", "CannonFire", new_key.physical_scancode)
		"dash":
			OptionsData.save_file("Inputs", "Dash", new_key.physical_scancode)
		"fall":
			OptionsData.save_file("Inputs", "Fall", new_key.physical_scancode)
	ResourceSaver.save("user://Data/game_data.tres", game_data)
	self.set_text(OS.get_scancode_string(new_key.physical_scancode))
	self.set_pressed(false)

func _input(event):
	if event is InputEventKey && key_changeable:
		change_key(event)

func toggle_buttons(status):
	self.set_pressed(status)
	key_changeable = status
