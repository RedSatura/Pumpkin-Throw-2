extends KinematicBody2D

const gravity = 9.8
var velocity = Vector2(0, 0)
var weight = 0

var rand_rotation_value = 0

func _ready():
	randomize()
	rand_rotation_value

func _physics_process(delta):
	pass
