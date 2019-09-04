extends Control


# Called when the node enters the scene tree for the first time.
func game_over():
	$GameOver.show()
	get_tree().paused = true


func update_lives(number):
	get_node("lives/Label").set_text(str(number))


func update_coins(number):
	get_node("coins/Label").set_text(str(number))
