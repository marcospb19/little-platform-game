extends Node2D

# Keep
var player_lives
var player_coins

var current_scene = null
var current_level = 1

onready var level1 = preload("res://Scenes/Levels/Level1.tscn")
onready var level2 = preload("res://Scenes/Levels/Level2.tscn")
onready var level_final = preload("res://Scenes/Levels/Level_Final.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	change_scene(level1 , false)


func backup():
	player_lives = get_child(1).get_node("Player/KinematicBody2D").lives
	player_coins = get_child(1).get_node("Player/KinematicBody2D").coins


func change_scene(scene , clear):
	if clear:
		self.remove_child(current_scene)
		#current_scene.free()

	current_scene = level1.instance()
	# Add it to the active scene, as child of root.
	self.add_child(current_scene)

	move_child(current_scene, 1)


func next_level():

	backup()

	if current_level == 1:
		print(current_level)
		change_scene(level1 , true)

	elif current_level == 2:
		change_scene(level2 , true)

	elif current_level == 3:
		change_scene(level_final , true)

	current_level += 1
