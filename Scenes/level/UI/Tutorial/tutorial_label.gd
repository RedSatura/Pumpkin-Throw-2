extends Label

enum CannonState {
	IDLE,
	AIMING,
	POWERING,
	FIRING,
}

var cannon_state = CannonState.AIMING

onready var timer = $Timer

func _ready():
	self.visible = SaveManager.game_data.special.tutorial_active
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_cannon_status", self, "update_text")
# warning-ignore:return_value_discarded
#	LevelEventBus.connect("show_level_uis", self, "show_mode")
	update_text(cannon_state)

func update_text(status):
	cannon_state = status
	match cannon_state:
		CannonState.IDLE:
			self.text = "IDLE"
		CannonState.AIMING:
			self.text = "Press " + str(OS.get_scancode_string(OptionsData.load_file("Inputs", "CannonUp", 16777232))) + " to raise the cannon!\n" + "Press " + str(OS.get_scancode_string(OptionsData.load_file("Inputs", "CannonDown", 16777234))) + " to lower the cannon!\n" + "If you are satisfied with the angle you have chosen, press " + str(OS.get_scancode_string(OptionsData.load_file("Inputs", "CannonFire", 88))) + "!"
		CannonState.POWERING:
			self.text = "The bar above the cannon is the power bar.\n" + "The higher it is, the more powerful your cannon gets!\n" + "Time it perfectly! Press " + str(OS.get_scancode_string(OptionsData.load_file("Inputs", "CannonFire", 88))) + " to fire your pumpkin!"
		CannonState.FIRING:
			self.text = "The buttons at the bottom can help your pumpkin go further!\n Press " + str(OS.get_scancode_string(OptionsData.load_file("Inputs", "Dash", 90))) + " to Dash and press " + str(OS.get_scancode_string(OptionsData.load_file("Inputs", "Fall", 88))) + " to fall!\n Try going as far as possible! Good luck!"
			SaveManager.game_data.special.tutorial_active = false
			SaveManager.save_data()
			timer.start(5)

func _on_Timer_timeout():
	self.visible = false
	
#func show_mode(status):
#	set_visible(status)
