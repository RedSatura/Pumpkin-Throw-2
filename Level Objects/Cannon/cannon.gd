extends Polygon2D

onready var pumpkin_spawner = $PumpkinSpawner

var cannon_disabled = false
var force = 1000
var angle = 0

func _unhandled_input(_event):
	if !cannon_disabled:
		if Input.is_action_just_pressed("cannon_fire"):
			var pumpkin = load("res://Level Objects/Pumpkin/pumpkin.tscn").instance()
			pumpkin.initial_force = force
			pumpkin.global_position = pumpkin_spawner.global_position
			pumpkin.cannon_angle = angle * -1
			get_parent().add_child(pumpkin)
			cannon_disabled = true

func _physics_process(_delta):
	if !cannon_disabled:
		if Input.is_action_pressed("cannon_up"):
			self.rotation_degrees -= 1
			if self.rotation_degrees < -90:
				self.rotation_degrees = -90
		elif Input.is_action_pressed("cannon_down"):
			self.rotation_degrees += 1
			if self.rotation_degrees > 0:
				self.rotation_degrees = 0
				
		angle = deg2rad(self.rotation_degrees)
