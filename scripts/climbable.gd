extends Area2D

# Handle start climb.
func _on_body_entered(body: Node2D):
	print("entered climbables")
	print(global_position)
	
	body.can_climb = true

func _on_body_exited(body: Node2D):
	print("exit climbables")
	print(global_position)
	
	body.can_climb = false
