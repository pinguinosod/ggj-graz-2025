extends Node3D

@export var humanPrefab: PackedScene
@export var rockPrefab: PackedScene

var isMoving = false
var movementSpeed = 3
var travelTime = 10
var timeTraveled = 0

func _ready() -> void:
	GameManager.movementStarted.connect(_handleMovementStarted)

func _process(delta: float) -> void:
	if isMoving:
		position.x -= movementSpeed * delta
		timeTraveled += delta
	if timeTraveled >= travelTime:
		timeTraveled = 0
		isMoving = false
		GameManager.startMinning()
		spawnRocks()
		spawnHumans()

func _handleMovementStarted():
	isMoving = true

func spawnRocks():
	for i in 3:
		spawnInstanceOf(rockPrefab)

func spawnHumans():
	for i in 3 * GameManager.currentVeinLevel:
		spawnInstanceOf(humanPrefab)

func spawnInstanceOf(prefab: PackedScene):
	var instance: Node3D = prefab.instantiate()
	instance.global_position = position + Vector3(randf_range(5, 10), 0, randf_range(5,10))
	add_child(instance)
