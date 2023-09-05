extends TextureProgress

enum PowerBarStatus {
	OFF,
	READY,
}

var power_bar_status = PowerBarStatus.OFF
var power_step = 1

func _ready():
	LevelEventBus.connect("set_power_bar_status", self, "set_power_bar_status")
	self.value = 0
	
func _physics_process(delta):
	match power_bar_status:
		PowerBarStatus.OFF:
			pass
		PowerBarStatus.READY:
			self.value += power_step
			if self.value < self.min_value:
				power_step *= -1
			elif self.value > self.max_value:
				power_step *= -1

func set_power_bar_status(status):
	if status == 0:
		power_bar_status = PowerBarStatus.OFF
	elif status == 1:
		power_bar_status = PowerBarStatus.READY
