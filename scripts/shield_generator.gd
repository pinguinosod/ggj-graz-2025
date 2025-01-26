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
		GameManager.damageShieldGenerator(20)
		
		var mesh: Mesh = $ShieldGenerator.mesh
		if mesh:
			var material: StandardMaterial3D = mesh.surface_get_material(1)
			var hitpoints = GameManager.shieldGeneratorHealth
			# Determine the color based on hitpoints
			var color: Color
			if hitpoints > 75: # Full HP to 75% HP
				color = Color(0.8, 0.85, 0.9) # Light blueish gray
			elif hitpoints > 50: # 75% to 50% HP
				color = Color(0.6, 0.65, 0.7) # Medium blueish gray
			elif hitpoints > 25: # 50% to 25% HP
				color = Color(0.4, 0.45, 0.5) # Darker blueish gray
			else: # 25% HP or lower
				color = Color(0.2, 0.25, 0.3) # Dark blueish gray
			
			# Update the material's albedo color
			material.albedo_color = color
