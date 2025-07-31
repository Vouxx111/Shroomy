extends RigidBody3D


@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_health_system_death() -> void:
	animation_player.play("death")
