extends Label

enum CannonState {
	IDLE,
	AIMING,
	POWERING,
	FIRING,
}

var cannon_state = CannonState.IDLE

func _ready():
	self.text = "Press " + str(OS.get_scancode_string(OptionsData.load_file("Inputs", "CannonUp", 16777232))) + " to raise the cannon!\n" + "Press " + str(OS.get_scancode_string(OptionsData.load_file("Inputs", "CannonDown", 16777234))) + " to lower the cannon!"

func update_text(status):
	match status:
		CannonState.IDLE:
			pass
		CannonState.AIMING:
			pass
		CannonState.POWERING:
			pass
		CannonState.FIRING:
			pass
