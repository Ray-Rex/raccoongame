extends Area2D

@onready var game_manager: Node = %GameManager
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pickup_sfx: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body):
	game_manager.add_point()
	pickup_sfx.play()
	animation_player.play("pickup")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
