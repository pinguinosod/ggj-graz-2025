extends RigidBody3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var targetPosDirection = Vector3.ZERO - global_position + Vector3(randf_range(-1.5, 1.5) * GameManager.vehicleUpgradeLevel,randf_range(5,8),randf_range(-1.5, 1.5) * GameManager.vehicleUpgradeLevel)
	var impulseDirection = targetPosDirection
	apply_impulse(impulseDirection)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	queue_free()

func doExplode() -> void:
	queue_free()
