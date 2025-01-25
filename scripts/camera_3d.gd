extends Camera3D

@export var target: Node3D
@export var offset: Vector3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position = target.position + (offset * GameManager.vehicleUpgradeLevel * 0.25) + Vector3(0, 2.5, 1.5)
