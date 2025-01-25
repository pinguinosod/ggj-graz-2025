extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var targetPosDirection = Vector3.ZERO - global_position + Vector3(randf_range(-0.5, 0.5) * GameManager.vehicleUpgradeLevel,randf_range(6,8),randf_range(-0.5, 0.5) * GameManager.vehicleUpgradeLevel)
	var impulseDirection = targetPosDirection
	apply_impulse(impulseDirection)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_rigid_body_3d_body_entered(body: Node) -> void:
	print(body)
	queue_free()


func _on_timer_timeout() -> void:
	queue_free()
