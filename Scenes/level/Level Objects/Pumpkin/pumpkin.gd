extends KinematicBody2D

var gravity = 250

export var bounce_divider = 1.2

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

var distance_in_meters = 0

onready var dash_cooldown = $DashCooldown
onready var fall_cooldown = $FallCooldown
onready var pumpkin_sprite = $Sprite

func _ready():
	randomize()
	rand_rotation_value = rand_range(-10, 10)
	velocity.y = -initial_force * sin(cannon_angle)
	velocity.x = initial_force * cos(cannon_angle)
	update_pumpkin_texture(SaveManager.game_data.current.pumpkin_texture_path)
# warning-ignore:return_value_discarded
# warning-ignore:return_value_discarded
	LevelEventBus.connect("end_game", self, "end_game")
	LevelEventBus.emit_signal("check_dash_cooldown", dash_enabled)
	LevelEventBus.emit_signal("check_fall_cooldown", fall_enabled)

func _physics_process(delta):
	velocity.y += gravity * delta
	distance_in_meters = convert_distance_to_meters(self.global_position.x)
	var collision = move_and_collide(velocity * delta)
	
	if game_status:
		self.rotation_degrees += rand_rotation_value
		if collision:
			velocity = velocity.bounce(collision.normal) / bounce_divider
	else:
		pass
	LevelEventBus.emit_signal("get_current_pumpkin_distance", distance_in_meters)
	LevelEventBus.emit_signal("get_pumpkin_position", self.global_position)
	LevelEventBus.emit_signal("check_dash_time_left", stepify(dash_cooldown.time_left, 0.1))
	LevelEventBus.emit_signal("check_fall_time_left", stepify(fall_cooldown.time_left, 0.1))
	
	if velocity.length() < 2.2:
		if game_status:
			end_game(true)

	if self.global_position.y < -1000 && velocity.y < 0:
		velocity.y = move_toward(velocity.y, 0, 5)
	
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
		dash_cooldown.start(1 + (dash_times * 0.05))
		LevelEventBus.emit_signal("check_dash_cooldown", dash_enabled)
		
	if Input.is_action_just_pressed("fall") && fall_enabled:
		velocity.y += 500
		fall_times += 1
		fall_enabled = false
		fall_cooldown.start(3 + (fall_times * 0.15))
		LevelEventBus.emit_signal("check_fall_cooldown", fall_enabled)

func _on_DashCooldown_timeout():
	dash_enabled = true
	LevelEventBus.emit_signal("check_dash_cooldown", dash_enabled)

func _on_FallCooldown_timeout():
	fall_enabled = true
	LevelEventBus.emit_signal("check_fall_cooldown", fall_enabled)

func _on_AreaDetector_area_entered(area):
	match area.get_collision_layer():
		4:
			velocity /= 2.5
		8:
			gravity = -1250
	
func save_data():
	SaveManager.game_data.current.money += calculate_money()
	SaveManager.game_data.statistics.total_money += calculate_money()
	if self.global_position.x > SaveManager.game_data.statistics.best_distance:
		SaveManager.game_data.statistics.best_distance = distance_in_meters
		SaveManager.game_data.statistics.best_actual_distance = self.global_position.x
	SaveManager.save_data()

func convert_distance_to_meters(dist):
	return floor((dist - 96) / 250)

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
		check_achievements()
		game_status = false
		
func update_pumpkin_texture(path):
	pumpkin_sprite.texture = load(path)
	
func check_achievements():
	#don't use save_data() here, i'll clean up my code later
	if distance_in_meters >= 100:
		SaveManager.game_data.achievements["100m_thrown"] = true
		SaveManager.save_data()
	if distance_in_meters >= 500:
		SaveManager.game_data.achievements["500m_thrown"] = true
		SaveManager.save_data()
	if distance_in_meters >= 1000:
		SaveManager.game_data.achievements["1km_thrown"] = true
		SaveManager.save_data()
	if distance_in_meters >= 42195:
		SaveManager.game_data.achievements["marathon_thrown"] = true
		SaveManager.save_data()

func _on_AreaDetector_area_exited(area):
	match area.get_collision_layer():
		4:
			pass
		8:
			gravity = 250
