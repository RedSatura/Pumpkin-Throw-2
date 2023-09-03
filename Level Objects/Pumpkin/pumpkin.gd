extends KinematicBody2D

const gravity = 150

var velocity = Vector2(0, 0)
var weight = 0
var initial_force = 0
var cannon_angle = 0

var rand_rotation_value = 0

func _ready():
	randomize()
	rand_rotation_value = rand_range(-10, 10)
	velocity.y = -initial_force * sin(cannon_angle)
	velocity.x = initial_force * cos(cannon_angle)

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
		queue_free()
