extends CharacterBody2D

var can_climb = false
var is_climbing = false
var not_jump_climax = false

const SPEED = 100.0
const CLIMB_SPEED = 100.0
const JUMP_VELOCITY = -250.0
const MULTIPLIER = 1.15

@onready var jump_sfx: AudioStreamPlayer2D = $JumpSFX
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

## TODO:
# 0. RUN
	# - just hold shift and the guy just moves faster
	# berhentinya lbh susah tho, ada animasi stop running (misal kyk sonic di smash)

# 1. JUMP
	# - jump klo udah max height, bs auto climb
	# - gerakan naik turunnya di 1 position x aja (maybe dri coordinate area 2d nya), 
	# nanti karakternya di automove ke posisi itu klo mulai climbing
	
# 2. WALLSLIDING
	# (di non climbables): drop nya pelan2, animasi nya beda, 
	# - kyk mario or megaman lg pegangan di wall
	# - bisa jump lagi dari wall nya (walljump, mungkin?)
	
# 3. DASH
	# (RUN N LEAP) horizontal jump
	# - pas nyentuh lantai (off the ledge jg bs)
	# pokoknya dia increase horizontal move for a fixed distance 
	# - invulnerability? lmao

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor() and is_climbing == false:
		velocity += get_gravity() * delta * MULTIPLIER
	
	# Handle state change to climbing.
	if can_climb == true:
		if Input.is_action_pressed("climb_up") or Input.is_action_pressed("climb_down"):
			is_climbing = true
		if Input.is_action_pressed("climb_up") and not not_jump_climax:
			is_climbing = true
	
	# Handle climbing movement.
	var direction_y := - Input.get_axis("climb_down", "climb_up")
	
	if can_climb == true:
		print(direction_y)
	
	if is_climbing == true:
		velocity.y = direction_y * CLIMB_SPEED
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and (is_on_floor() or is_climbing):
		jump_sfx.pitch_scale = randf_range(0.9, 1.1)
		jump_sfx.play()
		not_jump_climax = true
		velocity.y = JUMP_VELOCITY * MULTIPLIER
	
	# 1. Handle get out of climbable, 2. Handle jump in climbable.
	if can_climb == false or not_jump_climax == true:
		is_climbing = false
	# reached jump climax
	if velocity.y >= 0:
		not_jump_climax = false
	
	## Handle get out of climbing.
	#if can_climb == false or Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		#is_climbing = false
	
	# Get the input direction_x: -1, 0, 1
	var direction_x := Input.get_axis("move_left", "move_right")
	
	# Flip sprite
	if direction_x > 0:
		sprite.flip_h = false
	elif direction_x < 0:
		sprite.flip_h = true
	
	# Play animation
	if is_on_floor():
		if direction_x == 0:
			sprite.play("idle")
		else:
			sprite.play("run")
	else:
		sprite.play("jump")
	
	# Apply movement
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
