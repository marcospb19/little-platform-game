extends Area2D

# Flag
func _on_Area2D_body_entered(body):
	# If it was the player
	if body.get_name() == "KinematicBody2D":
		# Change the level
		get_tree().get_root().get_node("Root").next_level()
