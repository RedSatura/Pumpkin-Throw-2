extends Button

enum ButtonState {
	IDLE,
	CONFIRMING,
	RESETTING,
}

var button_state = ButtonState.IDLE

onready var timer = $Timer

func reset_data():
	SaveManager.reset_data()

func _on_ResetData_pressed():
	match button_state:
		ButtonState.IDLE:
			timer.start(3)
			button_state = ButtonState.CONFIRMING
			self.set_text("ARE YOU SURE?")
		ButtonState.CONFIRMING:
			timer.start(1)
			button_state = ButtonState.RESETTING
			reset_data()
			self.set_text("DATA RESET!")
		ButtonState.RESETTING:
			pass

func _on_Timer_timeout():
	match button_state:
		ButtonState.IDLE:
			pass
		ButtonState.CONFIRMING:
			button_state = ButtonState.IDLE
			self.set_text("RESET ALL DATA")
		ButtonState.RESETTING:
			button_state = ButtonState.IDLE
			self.set_text("RESET ALL DATA")
