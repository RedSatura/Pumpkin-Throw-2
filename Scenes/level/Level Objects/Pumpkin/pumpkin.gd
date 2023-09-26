extends KinematicBody2D

const gravity = 250

export var bounce_divider = 1.1

var velocity = Vector2(0, 0)
var weight = 0
var initial_force = 0
var cannon_angle = 0

var rand_rotation_value = 0

var dash_enabled = true
var fall_enabled = true

var dash_times = 0
var fall_times = 0

var game_status = true

onready var game_data = load("user://Data/game_data.tres") as GameData

onready var dash_cooldown = $DashCooldown
onready var fall_cooldown = $FallCooldown

func _ready():
	randomize()
	self.z_index = -1
	rand_rotation_value = rand_range(-10, 10)
	velocity.y = -initial_force * sin(cannon_angle)
	velocity.x = initial_force * cos(cannon_angle)
# warning-ignore:return_value_discarded
	LevelEventBus.connect("end_game", self, "end_game")
	LevelEventBus.emit_signal("check_dash_cooldown", dash_enabled)
	LevelEventBus.emit_signal("check_fall_cooldown", fall_enabled)

func _physics_process(delta):
	velocity.y += gravity * delta
	var collision = move_and_collide(velocity * delta)
	
	if game_status:
		self.rotation_degrees += rand_rotation_value
		if collision:
			velocity = velocity.bounce(collision.normal) / bounce_divider
	else:
		pass
		
	LevelEventBus.emit_signal("get_current_pumpkin_distance", convert_distance_to_meters(self.global_position.x))
	LevelEventBus.emit_signal("get_pumpkin_position", self.global_position)
	LevelEventBus.emit_signal("check_dash_time_left", stepify(dash_cooldown.time_left, 0.1))
	LevelEventBus.emit_signal("check_fall_time_left", stepify(fall_cooldown.time_left, 0.1))
	
	if velocity.length() < 2.2:
		if game_status:
			end_game(true)

	if self.global_position.y < -1000:
		velocity.y = move_toward(velocity.y, 0, 1)
	
	if self.global_position.x < 0:
		LevelEventBus.emit_signal("check_dash_cooldown", dash_enabled)
		LevelEventBus.emit_signal("check_fall_cooldown", fall_enabled)
		if velocity.x < 0:
			velocity.x += 1
		dash_enabled = false
		fall_enabled = false
		
func _unhandled_input(_event):
	if Input.is_action_just_pressed("dash") && dash_enabled:
		velocity.x += 200
		dash_times += 1
		dash_enabled = false
		dash_cooldown.start(1 + (dash_times * 0.1))
		LevelEventBus.emit_signal("check_dash_cooldown", dash_enabled)
		
	if Input.is_action_just_pressed("fall") && fall_enabled:
		velocity.y += 500
		fall_times += 1
		fall_enabled = false
		fall_cooldown.start(3 + (fall_times * 0.2))
		LevelEventBus.emit_signal("check_fall_cooldown", fall_enabled)

func _on_DashCooldown_timeout():
	dash_enabled = true
	LevelEventBus.emit_signal("check_dash_cooldown", dash_enabled)

func _on_FallCooldown_timeout():
	fall_enabled = true
	LevelEventBus.emit_signal("check_fall_cooldown", fall_enabled)

func _on_AreaDetector_area_entered(_area):
	velocity /= 2.5
	
func save_data():
	game_data.money += calculate_money()
	if self.global_position.x > game_data.best_actual_distance:
		game_data.best_distance = convert_distance_to_meters(self.global_position.x)
		game_data.best_actual_distance = self.global_position.x
	
	verify_save_existence()
	var _game_data_status = ResourceSaver.save("user://Data/game_data.tres", game_data)
	
func convert_distance_to_meters(dist):
	return round((dist - 96) / 250)
	
func verify_save_existence():
	var dir = Directory.new()
	dir.open("user://")
	if !dir.dir_exists("Data"):
		dir.make_dir("Data")

func calculate_money():
	return convert_distance_to_meters(self.global_position.x * 0.75)
	
func end_game(status):
	if status:
		velocity = Vector2.ZERO
		dash_enabled = false
		fall_enabled = false
		LevelEventBus.emit_signal("check_dash_cooldown", dash_enabled)
		LevelEventBus.emit_signal("check_fall_cooldown", fall_enabled)
		LevelEventBus.emit_signal("show_level_uis", false)
		LevelEventBus.emit_signal("show_game_over", 2)
		LevelEventBus.emit_signal("update_money_received", calculate_money())
		save_data()
		game_status = false
