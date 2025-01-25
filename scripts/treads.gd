extends Node3D

var isMoving = false

func _process(delta: float) -> void:
	if isMoving:
		$Node3D.position.y = randf_range(0, 0.125)

func _ready() -> void:
	GameManager.movementStarted.connect(_handleMovementStarted)
	GameManager.minningStarted.connect(_handleMinningStarted)


func _handleMovementStarted():
	isMoving = true
func _handleMinningStarted():
	isMoving = false
