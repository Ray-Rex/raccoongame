extends Area2D

@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	print("you died lol")
	body.get_node("DeathSFX").play()
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	#tambahin GTA killscreen: screen goes B&W
	timer.start()

#restart game when timer times out
func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
