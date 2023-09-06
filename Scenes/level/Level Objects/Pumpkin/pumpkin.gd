extends KinematicBody2D

const gravity = 250

var velocity = Vector2(0, 0)
var weight = 0
var initial_force = 0
var cannon_angle = 0

var rand_rotation_value = 0

var dash_enabled = true

onready var dash_cooldown = $DashCooldown
onready var dash_duration = $DashDuration

func _ready():
	randomize()
	self.z_index = -1
	rand_rotation_value = rand_range(-10, 10)
	velocity.y = -initial_force * sin(cannon_angle)
	velocity.x = initial_force * cos(cannon_angle)
	LevelEventBus.emit_signal("check_dash_cooldown", dash_enabled)

func _physics_process(delta):
	self.rotation_degrees += rand_rotation_value
	velocity.y += gravity * delta
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		rand_rotation_value = rand_range(-10, 10)
	LevelEventBus.emit_signal("get_current_pumpkin_distance", self.global_position.x)
	LevelEventBus.emit_signal("get_pumpkin_position", self.global_position)
	if self.global_position.y > 700:
		LevelEventBus.emit_signal("show_game_over", 2)
		queue_free()
		
func _unhandled_input(event):
	if Input.is_action_just_pressed("dash") && dash_enabled:
		velocity.x += 500
		dash_enabled = false
		dash_duration.start()
		dash_cooldown.start()
		LevelEventBus.emit_signal("check_dash_cooldown", dash_enabled)

func _on_DashCooldown_timeout():
	dash_enabled = true
	LevelEventBus.emit_signal("check_dash_cooldown", dash_enabled)

func _on_DashDuration_timeout():
	velocity.x -= 500
