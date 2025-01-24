extends Node3D

@onready var gridMap: GridMap = $GridMap

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		var clickPosition = get_cursor_world_position()
		print("Cursor click position: " + str(clickPosition))
		var cellClicked = gridMap.local_to_map(clickPosition)
		print("Clicked " + str(cellClicked))

func get_cursor_world_position() -> Vector3:
	const RAY_DISTANCE = 32
	
	var camera: Camera3D = get_viewport().get_camera_3d()
	if not is_instance_valid(camera):
		print("invalid camera")
		return Vector3.ZERO
	var mouse_pos = get_viewport().get_mouse_position()
	print("camera position: " + str(camera.global_position))
	print("mouse_pos: " + str(mouse_pos))
	
	var from: Vector3 = camera.project_ray_origin(mouse_pos)
	var to: Vector3 = from + camera.project_ray_normal(mouse_pos) * RAY_DISTANCE
	
	print("from "+str(from))
	print("to " + str(to))
	
	var ray_params := PhysicsRayQueryParameters3D.create(from, to)
	
	ray_params.collision_mask = 1 << 1 # layer 2

	var ray_result: Dictionary = get_world_3d().direct_space_state.intersect_ray(ray_params)
	
	return ray_result.get("position", to)# + offSet # - camera.global_position
