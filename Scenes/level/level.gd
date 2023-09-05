extends Node2D

onready var camera = $Camera2D

var bouncepad_number = 10

func _ready():
	LevelEventBus.connect("get_pumpkin_position", self, "update_camera_position")
	LevelEventBus.connect("get_current_pumpkin_distance", self, "spawn_bouncepad")
	for x in bouncepad_number:
		create_bouncepad(x)

func _unhandled_input(event):
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://Scenes/level/level.tscn")
	
func update_camera_position(pos):
	camera.set_zoom(Vector2(clamp(abs(pos.y - 700) / 500, 1, 2.5), clamp(abs(pos.y - 700) / 500, 1, 2.5)))
	camera.global_position = Vector2(pos.x, pos.y + 350)

func create_bouncepad(times_created):
	var bouncepad = load("res://Level Objects/Bouncepad/bouncepad.tscn").instance()
	bouncepad.global_position = Vector2(times_created * 500 + 1000, rand_range(500, 575))
	add_child(bouncepad)

func spawn_bouncepad(pos):
	if pos > bouncepad_number * 500 - 5000:
		create_bouncepad(bouncepad_number)
		bouncepad_number += 1
