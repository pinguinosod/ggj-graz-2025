extends Node3D

var targets: Array[Area3D]


func _process(delta: float) -> void:
	if targets.size() > 0:
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
