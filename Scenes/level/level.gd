extends Node2D

onready var camera = $Camera2D

var bouncepad_number = 50
var mud_number = 5

func _ready():
	LevelEventBus.connect("get_pumpkin_position", self, "update_camera_position")
	LevelEventBus.connect("get_current_pumpkin_distance", self, "spawn_bouncepad")
	LevelEventBus.connect("get_current_pumpkin_distance", self, "spawn_mud")
	for x in bouncepad_number:
		create_bouncepad(x)
	for x in mud_number:
		create_mud(x)

func _unhandled_input(event):
	if Input.is_action_just_pressed("restart"):
		get_tree().change_scene("res://Scenes/level/level.tscn")
	
func update_camera_position(pos):
	camera.set_zoom(Vector2(clamp(abs(pos.y - 700) / 500, 1, 2.5), clamp(abs(pos.y - 700) / 500, 1, 2.5)))
	camera.global_position = Vector2(pos.x, pos.y + 350)

func create_bouncepad(times_created):
	var bouncepad = load("res://Scenes/Level/Level Objects/Bouncepad/bouncepad.tscn").instance()
	bouncepad.global_position = Vector2(times_created * 500 + 1000, rand_range(225, 400))
	add_child(bouncepad)

func spawn_bouncepad(pos):
	if pos > bouncepad_number * 500 - 5000:
		create_bouncepad(bouncepad_number)
		bouncepad_number += 1
		
func create_mud(times_created):
	var mud = load("res://Scenes/Level/Level Objects/Mud/mud.tscn").instance()
	mud.global_position = Vector2(times_created * 1000 + 1500 + rand_range(-500, 500), 576)
	add_child(mud)
		
func spawn_mud(pos):
	if pos > mud_number * 1000 - 5000:
		create_mud(mud_number)
		mud_number += 1
