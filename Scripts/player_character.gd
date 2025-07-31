extends CharacterBody3D


@onready var player_character_model: Node3D = $"Player Character Model"

const SPEED = 10
var Health = 100
var maxHealth = 100

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction = Input.get_vector("Move Left", "Move Right", "Move Forward", "Move Backward")
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.y * SPEED
		
		# Rotate the mesh to face movement direction
		var target_rotation = atan2(-1 * (direction.y), direction.x)
		player_character_model.rotation.y = lerp_angle(player_character_model.rotation.y, target_rotation, delta * 10.0)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func take_damage(damage: int):
	Health -= damage
	print (Health)
