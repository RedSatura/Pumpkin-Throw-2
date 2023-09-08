extends Polygon2D

enum CannonState {
	IDLE,
	AIMING,
	POWERING,
	FIRING,
}

onready var pumpkin_spawner = $PumpkinSpawner

var cannon_state = CannonState.AIMING
var force = 1000
var angle = 0

func _ready():
	LevelEventBus.connect("get_power_bar_value", self, "set_cannon_force")

func _unhandled_input(_event):
	if Input.is_action_just_pressed("cannon_fire"):
		match cannon_state:
			CannonState.IDLE:
				pass
			CannonState.AIMING:
				cannon_state = CannonState.POWERING
			CannonState.POWERING:
				cannon_state = CannonState.FIRING
			CannonState.FIRING:
				pass
			
func _physics_process(_delta):
	match cannon_state:
			CannonState.IDLE:
				pass
			CannonState.AIMING:
				if Input.is_action_pressed("cannon_up"):
					self.rotation_degrees -= 1
				if self.rotation_degrees < -90:
					self.rotation_degrees = -90
				elif Input.is_action_pressed("cannon_down"):
					self.rotation_degrees += 1
				if self.rotation_degrees > 0:
					self.rotation_degrees = 0
			
				angle = deg2rad(self.rotation_degrees)
			CannonState.POWERING:
				LevelEventBus.emit_signal("set_power_bar_status", 1)
			CannonState.FIRING:
				LevelEventBus.emit_signal("set_power_bar_status", 0)
				LevelEventBus.emit_signal("show_level_uis", true)
				var pumpkin = load("res://Scenes/Level/Level Objects/Pumpkin/pumpkin.tscn").instance()
				pumpkin.initial_force = force
				pumpkin.global_position = pumpkin_spawner.global_position
				pumpkin.cannon_angle = angle * -1
				get_parent().add_child(pumpkin)
				cannon_state = CannonState.IDLE

func set_cannon_force(cannon_force):
	force *= (cannon_force * 2) / 200
