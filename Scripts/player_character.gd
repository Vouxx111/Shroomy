extends CharacterBody3D


@onready var player_character_model: Node3D = $"Player Character Model"
@onready var attack_ray: RayCast3D = $"Player Character Model/AttackRay"

const SPEED = 10
const DAMAGEAMOUNT = 10

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	var direction = Input.get_vector("Move Left", "Move Right", "Move Forward", "Move Backward")
	
	if Input.is_action_just_pressed("Attack"):
		attack()
	
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

func attack():
	if attack_ray.is_colliding():
		var body = attack_ray.get_collider()
		var healthNode = body.get_node_or_null("Health System")
		
		if healthNode and healthNode.has_method("take_damage"):
			healthNode.take_damage(DAMAGEAMOUNT)
