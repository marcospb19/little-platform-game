extends KinematicBody2D

# Variables
var motion = Vector2()
var is_couching = false
var is_being_moved = false
var is_running = false
var start_position = Vector2()

#
var lives = 3
var coins = 0

# Constants
const FLOOR_DIRECTION = Vector2(0,-1)
const JUMP_SPEED = -450
const SPEED = 50
const RUN_MULTIPLIER = 1.4
const GRAVITY = 25
const DRAG = 1.07

# Different sprites
var front_sprite = preload("res://Sprites/player/player_front.png")
var hurt_sprite = preload("res://Sprites/player/player_hurt.png")
var stand_sprite = preload("res://Sprites/player/player_stand.png")
var couching_sprite = preload("res://Sprites/player/player_duck.png")
var jumping_sprite = preload("res://Sprites/player/player_jump.png")


# The HUD
onready var HUD = get_node("../../../HUD")
# To change collision shape heigh
onready var thisCollisionShape = get_node("CollisionShape2D").get_shape()


func select_sprite(s):
	$AnimatedSprite.hide()
	$Sprite.set_texture(s)
	$Sprite.show()


func restart_animated_sprite():
	$AnimatedSprite.show()
	$AnimatedSprite.play('0')
	$Sprite.set_texture(front_sprite)
	$Sprite.hide()


func die():
	lives -= 1
	HUD.update_lives(lives)

	if lives == 0:
		# Update gui with "Game over!!"
		HUD.game_over()

	else:
		position = start_position


func collect_a_coin():

	coins += 1
	# Update gui with quantity of coins
	HUD.update_coins(coins)


func _ready():
	start_position = position


func _physics_process(delta):

	# Drag
	motion.x /= DRAG
	# Gravity
	motion.y += GRAVITY

	if Input.is_key_pressed(KEY_SHIFT):
		$AnimatedSprite.set_speed_scale(9)
		is_running = true
	else:
		$AnimatedSprite.set_speed_scale(5)
		is_running = false


	is_couching = false
	if Input.is_action_pressed("ui_down"):

		motion.x /= DRAG # Double down
		is_couching = true

		thisCollisionShape.set_height(12)
	else:
		thisCollisionShape.set_height(23)


	# Flip sprites
	if motion.x > 0:
		$Sprite.set_flip_h(false)
		$AnimatedSprite.set_flip_h(false)
	elif motion.x < 0:
		$Sprite.set_flip_h(true)
		$AnimatedSprite.set_flip_h(true)


	is_being_moved = false
	# Get horizontal movement input
	if Input.is_action_pressed("ui_left"):
		if not Input.is_action_pressed("ui_right"):

			# If boost
			if is_running:
				motion.x -= SPEED * RUN_MULTIPLIER
			else:
				motion.x -= SPEED
			is_being_moved = true

	elif Input.is_action_pressed("ui_right"):
		# If boost
		if is_running:
			motion.x += SPEED * RUN_MULTIPLIER
		else:
			motion.x += SPEED

		is_being_moved = true

	else:
		motion.x /= 1.13


	# Process the jump, and sprites
	# Change is_on_floor() to can_jump()
	if is_on_floor():
		# Is couching
		if is_couching:
			select_sprite(couching_sprite)

		# Starting jump and not couching
		elif Input.is_action_pressed("ui_up"):
			motion.y = JUMP_SPEED
			select_sprite(jumping_sprite)

		# Control sprites when on floor!!
		else:
			if is_being_moved:
				restart_animated_sprite()
			else:
				# if -20 < motion.x < 20
				if -20 < motion.x and motion.x < 20:
					select_sprite(front_sprite)
				else:
					select_sprite(stand_sprite)


	# Is not on floor, already jumped
	else:
		select_sprite(jumping_sprite)

	motion = move_and_slide(motion , FLOOR_DIRECTION)
