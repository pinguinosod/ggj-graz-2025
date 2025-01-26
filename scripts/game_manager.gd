extends Node

const TURRET_COST: int = 100

var mainScene: PackedScene = preload("res://scenes/main.tscn")
var endScene: PackedScene = preload("res://scenes/end_screen.tscn")
var mainMenuScene: PackedScene = preload("res://scenes/main_menu.tscn")
var gameStarted = false
var vehicleUpgradeLevel: int = 2
var resources: int = 100
var currentVeinLevel: int = 1
var veinResources: int = 50
var shieldGeneratorHealth: int = 100

signal veinDeepleted
signal movementStarted
signal minningStarted

func doMine() -> void:
	if veinResources > 0:
		veinResources -= 1
		resources += 1
	else:
		veinDeepleted.emit()

func addResources(howMuch: int) -> void:
	resources += howMuch

func spendResources(howMuch: int) -> bool:
	if howMuch <= resources:
		resources -= howMuch
		return true
	return false

func startMinning() -> void:
	currentVeinLevel += 1
	veinResources = currentVeinLevel * 20 # 200
	minningStarted.emit()

func damageShieldGenerator(dmg: int) -> void:
	shieldGeneratorHealth -= dmg
	if shieldGeneratorHealth <= 0:
		restartVariables()
		loadEndScene()

func loadEndScene() -> void:
	get_tree().change_scene_to_packed(endScene)

func loadMainScene() -> void:
	gameStarted = true
	get_tree().change_scene_to_packed(mainScene)

func loadMainMenu() -> void:
	gameStarted = false
	get_tree().change_scene_to_packed(mainMenuScene)

func restartVariables() -> void:
	vehicleUpgradeLevel = 2
	resources = 100
	currentVeinLevel = 1
	veinResources = 50
	shieldGeneratorHealth = 100
