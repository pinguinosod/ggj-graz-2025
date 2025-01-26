extends Node3D

var targets: Array[Area3D]
@export var shootParticlesPrefab: PackedScene
@export var hitpoints: int = 100

var gridMap: GridMap

func _ready() -> void:
	gridMap = get_tree().root.get_node("main/BaseVehicle/GridMap")

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


func _on_area_3d_hitbox_body_entered(body: Node3D) -> void:
	if body.has_method("doExplode"):
		body.doExplode()
		hitpoints -= 20

		# Ensure hitpoints are clamped between 0 and 100
		hitpoints = clamp(hitpoints, 0, 100)

		# Access the TurretHead's mesh and its material
		var turretHeadMesh: Mesh = $TurretHead.mesh
		if turretHeadMesh:
			# Ensure the material is unique to this instance
			var material: StandardMaterial3D = turretHeadMesh.surface_get_material(0)
			if material:

				# Determine the color based on hitpoints
				var color: Color
				if hitpoints > 75: # Full HP to 75% HP
					color = Color(0.8, 0.85, 0.9) # Light blueish gray
				elif hitpoints > 50: # 75% to 50% HP
					color = Color(0.6, 0.65, 0.7) # Medium blueish gray
				elif hitpoints > 25: # 50% to 25% HP
					color = Color(0.4, 0.45, 0.5) # Darker blueish gray
				else: # 25% HP or lower
					color = Color(0.2, 0.25, 0.3) # Dark blueish gray
				
				# Update the material's albedo color
				material.albedo_color = color
				turretHeadMesh.surface_set_material(0, material)

		# If hitpoints reach 0, free the node
		if hitpoints <= 0:
			print("pos: ", position)
			var cellPos = gridMap.local_to_map(position)
			cellPos.y = 0
			gridMap.set_cell_item(cellPos, -1)
			queue_free()
