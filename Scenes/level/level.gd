extends Node2D

onready var camera = $Camera2D

var bouncepad_number = 1
var mud_number = 1
var updraft_number = 1

var end_game_disabled = false

func _ready():
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_pumpkin_position", self, "update_camera_position")
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_current_pumpkin_distance", self, "spawn_bouncepad")
# warning-ignore:return_value_discarded
	LevelEventBus.connect("get_current_pumpkin_distance", self, "spawn_mud")
	LevelEventBus.connect("get_current_pumpkin_distance", self, "spawn_updraft")
	for x in bouncepad_number:
		create_bouncepad(x)
	for x in mud_number:
		create_mud(x)
	for x in updraft_number:
		create_updraft(x)

func _unhandled_input(_event):
	if Input.is_action_just_pressed("restart"):
		var _level_change_scene = get_tree().change_scene("res://Scenes/level/level.tscn")
		
	if Input.is_action_just_pressed("back_to_menu"):
		var _title_screen_change_scene = get_tree().change_scene("res://Scenes/Title Screen/title_screen.tscn")
		
	if Input.is_action_just_pressed("end_game") && !end_game_disabled:
		end_game_disabled = true
		LevelEventBus.emit_signal("end_game", true)
	
func update_camera_position(pos):
	camera.set_zoom(Vector2(clamp(abs(pos.y - 700) / 500, 1, 2.5), clamp(abs(pos.y - 700) / 500, 1, 2.5)))
	camera.global_position = Vector2(pos.x, pos.y + 350)

func create_bouncepad(times_created):
	var bouncepad = load("res://Scenes/Level/Level Objects/Bouncepad/bouncepad.tscn").instance()
	bouncepad.global_position = Vector2(times_created * 750 + 1000, rand_range(225, 400))
	add_child(bouncepad)

func spawn_bouncepad(pos):
	if pos > convert_distance_to_meters(bouncepad_number * 10 - 10):
		create_bouncepad(bouncepad_number)
		bouncepad_number += 1
		
func create_mud(times_created):
	var mud = load("res://Scenes/Level/Level Objects/Mud/mud.tscn").instance()
	mud.global_position = Vector2(times_created * 1250 + 1500 + rand_range(-500, 500), 576)
	add_child(mud)
		
func spawn_mud(pos):
	print(pos)
	if pos > convert_distance_to_meters(mud_number * 10 - 10):
		create_mud(mud_number)
		mud_number += 1
		
func create_updraft(times_created):
	var updraft = load("res://Scenes/Level/Level Objects/Updraft/updraft.tscn").instance()
	updraft.global_position = Vector2(times_created * 2000 + 1000 + rand_range(-300, 300), rand_range(-1000, -200))
	add_child(updraft)
		
func spawn_updraft(pos):
	if pos > convert_distance_to_meters(updraft_number * 10):
		create_updraft(updraft_number)
		updraft_number += 1

func convert_distance_to_meters(dist):
	return floor((dist - 96) / 250)
