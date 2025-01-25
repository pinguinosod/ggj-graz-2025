extends Node3D

func _ready() -> void:
	appear()

func dissapear() -> void:
	var initialRadius = 1.5 + GameManager.vehicleUpgradeLevel * 1.5
	var finalRadius = 0.1
	$CSGSphere3D.visible = false
	
	var tween = get_tree().create_tween()
	$CSGSphere3D.radius = initialRadius
	tween.tween_property($CSGSphere3D, "radius", finalRadius, 2)
	
func appear() -> void:
	$CSGSphere3D.visible = true
	var initialRadius = 0.1
	var finalRadius = 1.5 + GameManager.vehicleUpgradeLevel * 1.5
	
	var tween = get_tree().create_tween()
	$CSGSphere3D.radius = initialRadius
	tween.tween_property($CSGSphere3D, "radius", finalRadius, 2)
