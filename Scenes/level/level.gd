extends Node2D

onready var camera = $Camera2D

func _ready():
	LevelEventBus.connect("get_pumpkin_position", self, "update_camera_position")
	for x in 25:
		create_bouncepads(x)

func _unhandled_input(event):
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://Scenes/level/level.tscn")
	
func update_camera_position(pos):
	camera.set_zoom(Vector2(clamp(abs(pos.y - 700) / 500, 1, 150), clamp(abs(pos.y - 700) / 500, 1, 150)))
	camera.global_position = pos

func create_bouncepads(times_created):
	var bouncepad = load("res://Level Objects/Bouncepad/bouncepad.tscn").instance()
	bouncepad.global_position = Vector2(times_created * 500 + 1000, rand_range(500, 600))
	add_child(bouncepad)
