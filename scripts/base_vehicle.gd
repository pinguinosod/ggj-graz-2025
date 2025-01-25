extends Node3D

@export var TURRET_COST: int = 10
@onready var gridMap: GridMap = $GridMap
var buildings: Array[Vector3i]
var isMinning = true

func _ready() -> void:
	$CSGBox3DVehiclePlatform.size.x = 2+ 2*GameManager.vehicleUpgradeLevel
	$CSGBox3DVehiclePlatform.size.z = 2+ 2*GameManager.vehicleUpgradeLevel
	$StaticBody3DClickHandler/CollisionShape3D.shape.size = $CSGBox3DVehiclePlatform.size
	$Treads2.position.x = 0.5 + (1* GameManager.vehicleUpgradeLevel)
	$Treads3.position.x = -0.5 + (-1 * GameManager.vehicleUpgradeLevel)
	$Treads4.position.x = 0.5 + (1* GameManager.vehicleUpgradeLevel)
	$Treads5.position.x = -0.5 + (-1 * GameManager.vehicleUpgradeLevel)

	$Treads2.position.z = -1 + (-1 * GameManager.vehicleUpgradeLevel)
	$Treads3.position.z = -1 + (-1 * GameManager.vehicleUpgradeLevel)
	$Treads4.position.z = 1.5 + (1* GameManager.vehicleUpgradeLevel)
	$Treads5.position.z = 1.5 + (1* GameManager.vehicleUpgradeLevel)

func _process(delta: float) -> void:
	pass


func _input(event):
	var usedCells:Array[Vector3i] = gridMap.get_used_cells()
	for i in usedCells.size():
		if gridMap.get_cell_item(usedCells[i]) == 0:
			gridMap.set_cell_item(usedCells[i], -1)

	var cellMousePosition = gridMap.local_to_map(get_cursor_world_position())
	if cellMousePosition.y == 4:
		cellMousePosition.y = 0
		if event is InputEventMouseMotion and gridMap.get_cell_item(cellMousePosition) == -1:
			gridMap.set_cell_item(cellMousePosition, 0)
		elif event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			handleClickOnCell(cellMousePosition)

func handleClickOnCell(cellPos: Vector3i)-> void:
	if gridMap.get_cell_item(cellPos) == -1:
		if GameManager.spendResources(TURRET_COST):
			gridMap.set_cell_item(cellPos, 1) # turret base is on first floor
			gridMap.set_cell_item(Vector3(cellPos.x, 1, cellPos.z), 2) # turret head is on floor second floor

func get_cursor_world_position() -> Vector3:
	const RAY_DISTANCE = 64.0
	
	var camera: Camera3D = get_viewport().get_camera_3d()
	if not is_instance_valid(camera): return Vector3.ZERO
	var mouse_pos = get_viewport().get_mouse_position()
	
	var from: Vector3 = camera.project_ray_origin(mouse_pos)
	var to: Vector3 = from + camera.project_ray_normal(mouse_pos) * RAY_DISTANCE
	
	var ray_params := PhysicsRayQueryParameters3D.create(from, to)
	ray_params.collision_mask = 1 << 1 # layer 2
	var ray_result: Dictionary = get_world_3d().direct_space_state.intersect_ray(ray_params)
	
	var hit_position: Vector3 = ray_result.get("position", Vector3.ZERO)   
	
	return hit_position


func _on_minning_timer_timeout() -> void:
	if isMinning:
		GameManager.addResources(1)
