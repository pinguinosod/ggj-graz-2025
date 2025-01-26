extends Node3D

var targets: Array[Area3D]
@export var shootParticlesPrefab: PackedScene


func _process(delta: float) -> void:
	if targets.size() > 0 and is_instance_valid(targets[0]):
		# rotate to point towards targets[0]
		rotate_to_face_target(targets[0].global_position, delta)

func _on_area_3d_area_entered(area: Area3D) -> void:
	print("NEWTARGET: ", area)
	targets.push_back(area)


func _on_area_3d_area_exited(area: Area3D) -> void:
	targets.pop_front()


func rotate_to_face_target(targetPos: Vector3, delta: float) -> void:
	# Calculate the direction to the target
	var direction = (targetPos - global_transform.origin).normalized()

	# Calculate the target rotation on the Y axis
	var target_rotation_y = atan2(direction.x, direction.z)

	# Smoothly interpolate the current rotation towards the target rotation
	rotation.y = lerp_angle(rotation.y, target_rotation_y, 7.0 * delta)


func _on_timer_attack_timeout() -> void:
	if targets.size() > 0 and is_instance_valid(targets[0]) and targets[0].get_parent().has_method("doDamage"):
		targets[0].get_parent().doDamage()
		
		# Instantiate the particles
		var shootParticles = shootParticlesPrefab.instantiate()
		
		# Calculate the forward direction based on rotation
		var forward = -transform.basis.z.normalized() # Forward in the Z-axis of the object
		
		# Offset the particle's position based on forward direction and a custom X and Z offset
		var offset = forward * -0.2 + Vector3(0, -0.6, 0) # Adjust the `1.0` as needed for X/Z offset
		shootParticles.global_position = global_position + offset
		
		# Add the particles to the scene
		add_sibling(shootParticles)
