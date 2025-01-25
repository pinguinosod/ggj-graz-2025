extends Camera3D

@export var target: Node3D
@export var offset: Vector3
@export var cameraMovementDuration: float = 1.5

func _ready() -> void:
	GameManager.veinDeepleted.connect(_moveCameraToBehind)
	GameManager.minningStarted.connect(_moveCameraToSide)
	position = target.position + (offset * GameManager.vehicleUpgradeLevel * 0.25) + Vector3(0, 2.5, 1.5)

func _moveCameraToBehind() -> void:
	var finalPos = Vector3(-2 + (-2 * GameManager.vehicleUpgradeLevel), 4, 0)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "position", finalPos, cameraMovementDuration)
	tween.parallel().tween_property(self, "rotation_degrees:x", -35, cameraMovementDuration)
	tween.parallel().tween_property(self, "rotation_degrees:y", -90, cameraMovementDuration)

func _moveCameraToSide() -> void:
	var finalPos = target.position + (offset * GameManager.vehicleUpgradeLevel * 0.25) + Vector3(0, 2.5, 1.5)
	var tween = get_tree().create_tween()
	tween.parallel().tween_property(self, "position", finalPos, cameraMovementDuration)
	tween.parallel().tween_property(self, "rotation_degrees:x", -75, cameraMovementDuration)
	tween.parallel().tween_property(self, "rotation_degrees:y", 0, cameraMovementDuration)
