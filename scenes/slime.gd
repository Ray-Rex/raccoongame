extends Node2D

const SPEED = 50

# 1 = moving right, -1 = moving left
var dir = 1

@onready var ray_cast_left: RayCast2D = $"RayCast Left"
@onready var ray_cast_right: RayCast2D = $"RayCast Right"
@onready var ray_cast_down_left: RayCast2D = $"RayCast DownLeft"
@onready var ray_cast_down_right: RayCast2D = $"RayCast DownRight"
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if ray_cast_left.is_colliding():
		dir = 1
		sprite.flip_h = false
	elif ray_cast_right.is_colliding():
		dir = -1
		sprite.flip_h = true
	elif not ray_cast_down_left.is_colliding():
		dir = 1
		sprite.flip_h = false
	elif not ray_cast_down_right.is_colliding():
		dir = -1
		sprite.flip_h = true
	
	position.x += dir * SPEED * delta
