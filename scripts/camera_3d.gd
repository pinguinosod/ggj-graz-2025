extends Camera3D

@export var target: Node3D
@export var offset: Vector3
@export var cameraMovementDuration: float = 1.5

func _ready() -> void:
	GameManager.movementStarted.connect(_handleMovementStarted)
	GameManager.minningStarted.connect(_handleMinningStarted)
	position = target.position + (offset * GameManager.vehicleUpgradeLevel * 0.25) + Vector3(0, 2.5, 1.5)

func _handleMovementStarted() -> void:
	var finalPos = Vector3(-2 + (-2 * GameManager.vehicleUpgradeLevel), 4, 0)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "position", finalPos, cameraMovementDuration)
	tween.parallel().tween_property(self, "rotation_degrees:x", -35, cameraMovementDuration)
	tween.parallel().tween_property(self, "rotation_degrees:y", -90, cameraMovementDuration)

func _handleMinningStarted() -> void:
	var finalPos = target.position + (offset * GameManager.vehicleUpgradeLevel * 0.25) + Vector3(0, 2.5, 1.5)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "position", finalPos, cameraMovementDuration)
	tween.parallel().tween_property(self, "rotation_degrees:x", -75, cameraMovementDuration)
	tween.parallel().tween_property(self, "rotation_degrees:y", 0, cameraMovementDuration)
