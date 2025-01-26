extends Node3D

@export var humanPrefab: PackedScene
@export var rockPrefab: PackedScene
@export var cactusPrefab: PackedScene

var isMoving = false
var movementSpeed = 3
var travelTime = 20
var timeTraveled = 0

func _ready() -> void:
	GameManager.movementStarted.connect(_handleMovementStarted)
	spawnRocks()
	spawnHumans()
	spawnCacti()

func _process(delta: float) -> void:
	if isMoving:
		position.x -= movementSpeed * delta
		timeTraveled += delta
	if timeTraveled >= travelTime:
		timeTraveled = 0
		isMoving = false
		GameManager.startMinning()
		await get_tree().create_timer(1).timeout
		spawnRocks()
		spawnHumans()
		spawnCacti()

func _handleMovementStarted():
	isMoving = true

func spawnRocks():
	for i in 30:
		spawnInstanceOf(rockPrefab)

func spawnCacti():
	for i in 30:
		spawnInstanceOf(cactusPrefab)

func spawnHumans():
	for i in 5 * GameManager.currentVeinLevel:
		spawnInstanceOf(humanPrefab, 8 + (2 * GameManager.vehicleUpgradeLevel), 80+ (2 * GameManager.vehicleUpgradeLevel), 2 + (2 * GameManager.vehicleUpgradeLevel), 6 + (2 * GameManager.vehicleUpgradeLevel))

func spawnInstanceOf(prefab: PackedScene, minX: float = 15, maxX :float = 120, minZ: float = 8, maxZ :float = 64):
	var instance: Node3D = prefab.instantiate()
	var positionZ = randf_range(minZ, maxZ)
	var positionX = randf_range(minX, maxX)
	instance.global_position = Vector3(positionX, 0, positionZ) - position
	if randi_range(0,100) > 50:
		instance.position.z = -1 * positionZ
	add_child(instance)
