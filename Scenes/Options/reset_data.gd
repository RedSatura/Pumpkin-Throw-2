extends Button

enum ButtonState {
	IDLE,
	CONFIRMING,
	RESETTING,
}

var button_state = ButtonState.IDLE

onready var game_data = load("user://Data/game_data.tres") as GameData

func reset_data():
	game_data.best_distance = 0
	game_data.best_actual_distance = 0
	game_data.money = 0
	
	ResourceSaver.save("user://Data/game_data.tres", game_data)

func _on_ResetData_pressed():
	match button_state:
		ButtonState.IDLE:
			button_state = ButtonState.CONFIRMING
			self.set_text("ARE YOU SURE?")
		ButtonState.CONFIRMING:
			button_state = ButtonState.RESETTING
			reset_data()
			self.set_text("DATA RESET!")
		ButtonState.RESETTING:
			button_state = ButtonState.IDLE
			self.set_text("RESET ALL DATA")
