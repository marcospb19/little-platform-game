extends Area2D

var collected = false
# Coin collected
func _on_Area2D_body_entered(body):

	# If it was the player
	if body.get_name() == "KinematicBody2D" and not collected:
		collected = true
		body.collect_a_coin()
		$Sprite.hide()
