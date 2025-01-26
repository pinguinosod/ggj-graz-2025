extends Node3D

@export var enemyProjectilePrefab: PackedScene
var targetEnemy:Node3D = null
var isDying = false
var hitpoints = 2

func _process(delta: float) -> void:
	if !isDying:
		if targetEnemy:
			$AnimationPlayer.play("attacking")
			rotate_to_face_target(delta)
		else:
			$AnimationPlayer.play("idle")

func rotate_to_face_target(delta: float) -> void:
	# Calculate the direction to the target
	var direction = (targetEnemy.global_transform.origin - global_transform.origin).normalized()

	# Calculate the target rotation on the Y axis
	var target_rotation_y = atan2(direction.x, direction.z)

	# Smoothly interpolate the current rotation towards the target rotation
	rotation.y = lerp_angle(rotation.y, target_rotation_y, 7.0 * delta)

func _on_area_3d_attack_range_body_entered(body: Node3D) -> void:
	targetEnemy = body

func _on_area_3d_attack_range_body_exited(body: Node3D) -> void:
	targetEnemy = null

func spawnProjectile() -> void:
	if targetEnemy:
		var enemyProjectile = enemyProjectilePrefab.instantiate()
		enemyProjectile.position = global_position
		enemyProjectile.position.y = 0.7
		get_tree().root.get_node("main").add_child(enemyProjectile)

func doDamage() -> void:
	hitpoints -= 1
	if hitpoints <= 0:
		isDying = true
		$AudioStreamPlayer3D2.play()
		$AnimationPlayer.play("death")
	else:
		$AudioStreamPlayer3D.play()

func dissapear() -> void:
	queue_free()
