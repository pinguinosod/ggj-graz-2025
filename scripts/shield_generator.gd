extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_3d_hitbox_body_entered(body: Node3D) -> void:
	if body.has_method("doExplode"):
		body.doExplode()
		GameManager.damageShieldGenerator(1)
