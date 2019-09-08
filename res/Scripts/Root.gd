extends Node2D

# Keep
var player_lives = 3
var player_coins = 0

var current_scene = null
var current_level = 1

var main_menu = ""
var path_level1 = "res://Scenes/Levels/Level1.tscn"
var path_level2 = "res://Scenes/Levels/Level2.tscn"
var path_level_final = "res://Scenes/Levels/Level_Final.tscn"

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	change_scene(path_level1 , false)


func backup():
	player_lives = get_child(1).get_node("Player/KinematicBody2D").lives
	player_coins = get_child(1).get_node("Player/KinematicBody2D").coins


func next_level():

	backup()
	if current_level == 1:
		print(current_level)
		change_scene(path_level1 , true)

	elif current_level == 2:
		change_scene(path_level2 , true)

	elif current_level == 3:
		change_scene(path_level_final , true)

	current_level += 1

func change_scene(scene_path , clear):
	call_deferred("_deferred_goto_scene", scene_path , clear)

func _deferred_goto_scene(scene_path , clear):

	# Remove the current scene
	if clear:
		current_scene.free()

	var scene = ResourceLoader.load(scene_path)
	current_scene = scene.instance()
	get_tree().get_root().get_node("Root").add_child(current_scene)
	get_tree().set_current_scene(current_scene)

	move_child(current_scene , 1)
