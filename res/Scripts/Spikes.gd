extends Area2D

# Spikes hitted collected
func _on_Area2D_body_entered(body):
	# If it was the player
	if body.get_name() == "KinematicBody2D":
		body.die()
