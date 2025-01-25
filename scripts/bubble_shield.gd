extends Node3D

func _ready() -> void:
	appear()
	GameManager.minningStarted.connect(_handleMinningStarted)
	GameManager.veinDeepleted.connect(_handleVeinDeepleted)

func _process(delta: float) -> void:
	$StaticBody3D/CollisionShape3D.shape.radius = $CSGSphere3D.radius

func _handleMinningStarted() -> void:
	appear()

func _handleVeinDeepleted() -> void:
	dissapear()

func dissapear() -> void:
	var initialRadius = 1.5 + GameManager.vehicleUpgradeLevel * 1.5
	var finalRadius = 0.01
	
	var tween = get_tree().create_tween()
	$CSGSphere3D.radius = initialRadius
	tween.tween_property($CSGSphere3D, "radius", finalRadius, 2)
	tween.parallel().tween_property($CSGSphere3D, "visible", false, 2)
	tween.tween_callback(GameManager.movementStarted.emit)
	
func appear() -> void:
	$CSGSphere3D.visible = true
	var initialRadius = 0.01
	var finalRadius = 1.5 + GameManager.vehicleUpgradeLevel * 1.5
	
	var tween = get_tree().create_tween()
	$CSGSphere3D.radius = initialRadius
	tween.tween_property($CSGSphere3D, "radius", finalRadius, 2)
