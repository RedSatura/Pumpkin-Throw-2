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
	$Camera2D.current = true
	velocity.y = -initial_force * sin(cannon_angle)
	velocity.x = initial_force * cos(cannon_angle)
	
	#angle = deg2rad(angle)
	
	#velocity.x *= rad2deg(cos(angle))
	#velocity.y *= rad2deg(sin(angle))

func _physics_process(delta):
	self.rotation_degrees += rand_rotation_value
	print(velocity)
	velocity.y += gravity * delta
	var collision = move_and_collide(velocity * delta)
