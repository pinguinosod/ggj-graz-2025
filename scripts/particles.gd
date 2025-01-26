extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
		if get_tree().root.get_node("main/MovingEnvironment").isMoving:
			$CPUParticles3D.gravity.x = -2
		$CPUParticles3D.restart()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_cpu_particles_3d_finished() -> void:
	queue_free()
