extends TextureProgress

enum PowerBarStatus {
	OFF,
	READY,
}

var power_bar_status = PowerBarStatus.OFF
var power_step = 1

func _ready():
	self.visible = false
# warning-ignore:return_value_discarded
	LevelEventBus.connect("set_power_bar_status", self, "set_power_bar_status")
	self.value = 0
	
func _unhandled_input(_event):
	if Input.is_action_just_pressed("cannon_fire"):
		match power_bar_status:
			PowerBarStatus.OFF:
				pass
			PowerBarStatus.READY:
				LevelEventBus.emit_signal("get_power_bar_value", self.value)
	
func _physics_process(_delta):
	match power_bar_status:
		PowerBarStatus.OFF:
			self.visible = false
		PowerBarStatus.READY:
			self.visible = true
			if self.value <= self.min_value:
				power_step = 1
			elif self.value >= self.max_value:
				power_step = -1
			self.value += power_step

func set_power_bar_status(status):
	if status == 0:
		power_bar_status = PowerBarStatus.OFF
	elif status == 1:
		power_bar_status = PowerBarStatus.READY
